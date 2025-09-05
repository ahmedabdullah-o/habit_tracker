import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';
import 'package:habit_tracker/core/db/tables/habits_details.dart';
import 'package:habit_tracker/core/entities/days_of_week.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/extensions/habit_data_extensions.dart';
import 'package:habit_tracker/core/extensions/string_extensions.dart';
import 'package:habit_tracker/core/extensions/value_extensions.dart';
import 'package:logging/logging.dart';

part 'habits_dao.g.dart';

@DriftAccessor(tables: [Habits, HabitsDetails])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.db);

  // Hierarchical logger instance for this DAO
  static final Logger _logger = Logger('HabitTracker.Database.HabitsDao');

  // These caches are used for fast access to the habits
  // after they're queried for the first time.
  //
  // The data in these variables never get actually invalidated
  // becasue methods that edit the list of habits update these
  // caches along with them, so the next time an edit is done
  // it's quickly added to the cache and they're ready to use.
  List<HabitData>? _habitsCache;
  List<HabitData>? _habitsTodayCache;

  Future<void> _validateHabitData(HabitData habitData) async {
    _logger.fine(
      '_validateHabitData: Validating habit data for habit: ${habitData.name.safeValue ?? 'null'}',
    );

    // Check if both repeat are mutually exclusive.
    // This is important because the user can only use
    // one repeat pattern per habit, either repeat on
    // specific days or on a set interval (every N days).
    if ((habitData.repeatEveryNDays.value == null &&
            habitData.repeatOnDaysOfWeek.value == null) ||
        (habitData.repeatEveryNDays.value != null &&
            habitData.repeatOnDaysOfWeek.value != null)) {
      _logger.warning(
        '_validateHabitData: Validation failed: Invalid repeat pattern configuration',
      );
      throw Exception(
        'One of the following properties has to have a value and they can\'t both be NULL:\nrepeatOnDaysOfWeek, repeatEveryNDays)',
      );
    }

    if (habitData.goalDeadline.value != null) {
      if (habitData.goalDeadline.value!.isBefore(DateTime.now())) {
        _logger.warning(
          '_validateHabitData: Validation failed: Goal deadline is in the past',
        );
        throw Exception('You can\'t set deadline as a time in the past');
      }
    }

    try {
      final categoryExists =
          await (select(db.categories)
                ..where((tbl) => tbl.id.equals(habitData.categoryId.value)))
              .getSingleOrNull();

      if (categoryExists == null) {
        _logger.warning(
          '_validateHabitData: Validation failed: Category ${habitData.categoryId.value} does not exist',
        );
        throw Exception('No category exists with the given ID.');
      }
    } catch (e) {
      _logger.severe(
        '_validateHabitData: Validation error during category check',
        e,
      );
      throw Exception(e.toString());
    }

    _logger.fine('_validateHabitData: Habit data validation passed');
  }

  Future<int?> insertHabit(HabitData habitData) async {
    _logger.info(
      'insertHabit: Starting insertHabit for: ${habitData.name.safeValue ?? 'null'}',
    );
    _logger.fine(
      'insertHabit: Current cache state - _habitsCache: ${_habitsCache?.length ?? 'null'}, _habitsTodayCache: ${_habitsTodayCache?.length ?? 'null'}',
    );

    // throws exception if something is wrong with the data
    await _validateHabitData(habitData);

    // gotta make sure id & currentVersion aren't assigned manually.
    // because id corresponds to the PK of the row, and currentVersion
    // corresponds to the FK of the current habit details version.
    // Editing these values manually may cause all types of problems!
    if (habitData.id != Value.absent() ||
        habitData.currentVersion != Value.absent()) {
      _logger.warning(
        'insertHabit: Insert failed: id or currentVersion manually assigned',
      );
      throw Exception(
        '`HabitData().id` & `HabitData().currentVersion` must be absent (e.g. equal `Value.absent()`)',
      );
    }

    // The time format should be like this: "HH:mm".
    // When querying, this string gets parsed to a TimeOfDay variable,
    // which may only work with this specific format.
    final reminderTime =
        "${habitData.reminderTime.value.hour.toString().padLeft(2, '0')}:${habitData.reminderTime.value.minute.toString().padLeft(2, '0')}";
    _logger.fine('insertHabit: Formatted reminder time: $reminderTime');

    int? rowId;
    try {
      await transaction(() async {
        _logger.fine('insertHabit: Starting database transaction');

        // habits and habits details are two different tables because
        // we may want to go back to previous data for various reasons,
        // like determining streaks or training ML models to the user
        // behaviour for feedback and what not.
        // So, this is only useful for streaks in the moment.
        rowId = await into(habits).insert(
          HabitsCompanion.insert(
            id: Value.absent(),
            currentVersion: Value(1),
            // TODO: googleSub = API request / shared_pref fetch data
            createdAt: Value(DateTime.now()),
            isDeleted: Value(false),
          ),
        );
        if (rowId == null) {
          throw Exception('insert into habits table failed');
        }
        _logger.fine('insertHabit: Inserted into habits table with ID: $rowId');

        await into(db.habitsDetails).insert(
          HabitsDetailsCompanion.insert(
            id: Value.absent(),
            habitId: rowId!,
            version: Value(1),
            editDatetime: Value(DateTime.now()),
            name: habitData.name.value,
            description: habitData.desc.value,
            categoryId: habitData.categoryId.value,
            startDatetime: habitData.startDatetime.value,
            endDatetime: habitData.endDatetime,
            reminderTime: Value(reminderTime),
            repeatOnDaysOfWeek: Value(
              DaysOfWeek.formatForDB(habitData.repeatOnDaysOfWeek.value),
            ),
            repeatEveryNDays: habitData.repeatEveryNDays,
            targetUnit: habitData.targetUnit,
            targetQuantity: habitData.targetQuantity,
            goalCompletionRate: habitData.goalCompletionRate,
            goalDeadline: habitData.goalDeadline,
            isArchived: habitData.isArchived,
          ),
        );
        _logger.fine('insertHabit: Inserted into habits_details table');

        // This is where we add the data to the cache.
        // The data is inserted into the cache variables in ascending
        // order according to reminderTime, this is because it's the
        // habits should be shown represented in this order for
        // convinence, it's more likely that the user would want to
        // see his upcoming habits first.
        habitData.id = Value(rowId!);
        if (_habitsCache == null) {
          _logger.fine(
            'insertHabit: _habitsCache is null. invoking getAllHabits()',
          );
          await getAllHabits();
        } else if (await getAllHabits() != null) {
          _logger.fine(
            'insertHabit: Updating existing _habitsCache (${_habitsCache!.length} items)',
          );
          bool inserted = false;
          for (int i = 0; i < _habitsCache!.length; i++) {
            if (_habitsCache![i].reminderTime.value.isAfter(
              habitData.reminderTime.value,
            )) {
              _habitsCache!.insert(i, habitData);
              inserted = true;
              _logger.fine(
                'insertHabit: Inserted habit into cache at position $i',
              );
              break;
            }
          }
          if (!inserted) {
            _habitsCache!.add(habitData);
            _logger.fine('insertHabit: Added habit to end of cache');
          }
        } else {
          _habitsCache = [habitData];
          _logger.fine('insertHabit: Created new _habitsCache with 1 item');
        }

        // trigger getTodayHabits() to update _habitsTodayCache
        getTodayHabits();

        _logger.fine('insertHabit: Transaction completed successfully');
      });
    } catch (e) {
      _logger.severe('insertHabit: Error during insertHabit', e);
      throw Exception(e.toString());
    }

    _logger.info('insertHabit: insertHabit completed successfully');
    return rowId;
  }

  Future<int?> editHabitDetails(HabitData newDetails) async {
    // replacing all absent values with values from the latest version
    // of habit details
    final query =
        await (select(habitsDetails)
              ..where((u) => u.habitId.equals(newDetails.id.value))
              ..where((u) => u.version.equals(newDetails.currentVersion.value)))
            .getSingleOrNull();

    if (query == null) {
      throw Exception('the habit you\'re trying to edit doesn\'t exist');
    }

    newDetails = HabitData(
      id: newDetails.id,
      currentVersion: newDetails.currentVersion,
      name: newDetails.name == Value.absent()
          ? Value(query.name)
          : newDetails.name,
      desc: newDetails.desc == Value.absent()
          ? Value(query.description)
          : newDetails.desc,
      categoryId: newDetails.categoryId == Value.absent()
          ? Value(query.categoryId)
          : newDetails.categoryId,
      startDatetime: newDetails.startDatetime == Value.absent()
          ? Value(query.startDatetime)
          : newDetails.startDatetime,
      endDatetime: newDetails.endDatetime == Value.absent()
          ? Value(query.endDatetime)
          : newDetails.endDatetime,
      reminderTime: newDetails.reminderTime == Value.absent()
          ? Value(query.reminderTime!.toTimeOfDay())
          : newDetails.reminderTime,
      repeatOnDaysOfWeek: newDetails.repeatOnDaysOfWeek == Value.absent()
          ? Value(DaysOfWeek.parseFromDB(query.repeatOnDaysOfWeek))
          : newDetails.repeatOnDaysOfWeek,
      repeatEveryNDays: newDetails.repeatEveryNDays == Value.absent()
          ? Value(query.repeatEveryNDays)
          : newDetails.repeatEveryNDays,
      targetUnit: newDetails.targetUnit == Value.absent()
          ? Value(query.targetUnit)
          : newDetails.targetUnit,
      targetQuantity: newDetails.targetQuantity == Value.absent()
          ? Value(query.targetQuantity)
          : newDetails.targetQuantity,
      goalCompletionRate: newDetails.goalCompletionRate == Value.absent()
          ? Value(query.goalCompletionRate)
          : newDetails.goalCompletionRate,
      goalDeadline: newDetails.goalDeadline == Value.absent()
          ? Value(query.goalDeadline)
          : newDetails.goalDeadline,
      isArchived: newDetails.isArchived == Value.absent()
          ? Value(query.isArchived)
          : newDetails.isArchived,
    );

    _logger.info(
      'editHabitDetails: Starting editHabitDetails for habit ID: ${newDetails.id.value}',
    );
    _logger.fine(
      'editHabitDetails: Current cache state - _habitsCache: ${_habitsCache?.length ?? 'null'}, _habitsTodayCache: ${_habitsTodayCache?.length ?? 'null'}',
    );

    await _validateHabitData(newDetails);

    if (newDetails.id == Value.absent() ||
        newDetails.currentVersion == Value.absent()) {
      _logger.warning(
        'editHabitDetails: Edit failed: id or currentVersion is absent',
      );
      throw Exception(
        'Can\'t edit a habit with undefined id or currentVersion. these fields should be already assigned by the query method and should NOT be assigned or modified manually.',
      );
    }

    // Each habit has multiple versions stored in the habits details table
    // Why not just overwrite the current version? Because we might need
    // older details for things like streak tracking.
    final newVersionNum = Value(newDetails.currentVersion.value + 1);
    _logger.fine(
      'editHabitDetails: New version number: ${newVersionNum.value}',
    );

    final reminderTime =
        "${newDetails.reminderTime.value.hour.toString().padLeft(2, '0')}:${newDetails.reminderTime.value.minute.toString().padLeft(2, '0')}";

    try {
      await transaction(() async {
        _logger.fine('editHabitDetails: Starting edit transaction');

        // Here we edit the currentVersion in the main habits table which is
        // used to store all the habits the user ever created, but when an
        // edit happens we just insert the new details and keep the older ones.
        final updatedRows =
            await (update(habits)
                  ..where((tbl) => tbl.id.equals(newDetails.id.value)))
                .write(HabitsCompanion(currentVersion: newVersionNum));
        _logger.fine(
          'editHabitDetails: Updated habits table, rows affected: $updatedRows',
        );

        await (into(db.habitsDetails).insert(
          HabitsDetailsCompanion.insert(
            id: Value.absent(),
            habitId: newDetails.id.value,
            version: newVersionNum,
            editDatetime: Value(DateTime.now()),
            name: newDetails.name.value,
            description: newDetails.desc.value,
            categoryId: newDetails.categoryId.value,
            startDatetime: newDetails.startDatetime.value,
            endDatetime: newDetails.endDatetime,
            reminderTime: Value(reminderTime),
            repeatEveryNDays: newDetails.repeatEveryNDays,
            repeatOnDaysOfWeek: Value(
              DaysOfWeek.formatForDB(newDetails.repeatOnDaysOfWeek.value),
            ),
            targetUnit: newDetails.targetUnit,
            targetQuantity: newDetails.targetQuantity,
            goalCompletionRate: newDetails.goalCompletionRate,
            goalDeadline: newDetails.goalDeadline,
            isArchived: newDetails.isArchived,
          ),
        ));
        _logger.fine(
          'editHabitDetails: Inserted new version into habits_details table',
        );

        // Update cache
        if (_habitsCache != null) {
          bool found = false;
          for (int i = 0; i < _habitsCache!.length; i++) {
            if (_habitsCache![i].id.value == newDetails.id.value) {
              _habitsCache![i] = newDetails;
              found = true;
              _logger.fine(
                'editHabitDetails: Updated habit in _habitsCache at position $i',
              );
              break;
            }
          }
          if (!found) {
            _logger.warning(
              'editHabitDetails: Habit not found in _habitsCache for update',
            );
          }
        } else {
          _logger.warning(
            'editHabitDetails: _habitsCache is null, cannot update cache',
          );
        }

        // Update today cache if needed
        if (_habitsTodayCache != null) {
          bool found = false;
          for (int i = 0; i < _habitsTodayCache!.length; i++) {
            if (_habitsTodayCache![i].id.value == newDetails.id.value) {
              if (newDetails.isDueToday()) {
                _habitsTodayCache![i] = newDetails;
                _logger.fine(
                  'editHabitDetails: Updated habit in _habitsTodayCache at position $i',
                );
              } else {
                _habitsTodayCache!.removeAt(i);
                _logger.fine(
                  'editHabitDetails: Removed habit from _habitsTodayCache (no longer due today)',
                );
              }
              found = true;
              break;
            }
          }
          if (!found && newDetails.isDueToday()) {
            // Add to today cache if it's now due today but wasn't before
            _habitsTodayCache!.add(newDetails);
            _logger.fine(
              'editHabitDetails: Added habit to _habitsTodayCache (now due today)',
            );
          }
        }

        _logger.fine(
          'editHabitDetails: Edit transaction completed successfully',
        );
        return newVersionNum.value;
      });
    } catch (e, s) {
      _logger.severe('editHabitDetails: Error during editHabitDetails', e, s);
      throw Exception(e.toString());
    }
    return null;
  }

  Future<List<HabitData>?> getAllHabits() async {
    _logger.fine('getAllHabits: getAllHabits called');

    // Check if there's an available cache to return.
    // Cache data is only available when this method (getAllHabits()) is called
    // prior.
    if (_habitsCache != null) {
      _logger.fine(
        'getAllHabits: Returning cached habits (${_habitsCache!.length} items)',
      );
      return _habitsCache;
    }

    _logger.fine('getAllHabits: No cache available, querying database');
    List<Habit> habitsRows = [];
    List<int> habitIds = [];
    List<HabitsDetail> habitsDetailsRows = [];

    try {
      // query habits table
      habitsRows =
          await (select(
                  habits,
                  // only querying undeleted habits
                )
                ..where((tbl) => tbl.isDeleted.equals(false))
                ..orderBy([
                  // order by creation time
                  (u) => OrderingTerm(expression: u.createdAt),
                ]))
              .get();
      _logger.fine(
        'getAllHabits: Found ${habitsRows.length} habits in database',
      );

      // extracting id column for habits_details query
      habitIds = habitsRows.map((row) => row.id).toList();
      _logger.fine('getAllHabits: Habit IDs: $habitIds');

      // query habits_details table
      habitsDetailsRows =
          await (select(db.habitsDetails)
                // querying details for only undeleted habits
                ..where((tbl) => tbl.habitId.isIn(habitIds)))
              .get();
      _logger.fine(
        'getAllHabits: Found ${habitsDetailsRows.length} habit details rows',
      );
    } catch (e) {
      _logger.severe('getAllHabits: Error querying database', e);
      throw Exception(e.toString());
    }
    final latestDetailsMap = <int, HabitsDetail>{};

    // grouping latest details only into latestDetailsMap.
    // Because older habit details persist in the habitsDetails table.
    for (final detail in habitsDetailsRows) {
      final existing = latestDetailsMap[detail.habitId];
      if (existing == null || detail.version > existing.version) {
        latestDetailsMap[detail.habitId] = detail;
      }
    }
    _logger.fine(
      'getAllHabits: Found latest versions for ${latestDetailsMap.length} habits',
    );

    // replacing with only the latest details
    habitsDetailsRows.clear();
    habitsDetailsRows.addAll(latestDetailsMap.values.toList());

    // mapping to HabitData entities for output
    final List<HabitData> out = [];

    for (int i = 0; i < habitsDetailsRows.length; i++) {
      _logger.finer(
        'getAllHabits: found habit:\n${habitsRows[i].toJsonString()}',
      );
      // parsing to valid types

      // First we have this repeat pattern which we made an entity for called
      // DaysOfWeek. It's stored in the database as a binary string with each
      // bit corresponding to a day in the week from Mon to Sat. e.g.: '1010101'
      // So, we need to turn it back into a DaysOfWeek entity when querying.
      final repeatOnDaysOfWeek = DaysOfWeek.parseFromDB(
        habitsDetailsRows[i].repeatOnDaysOfWeek,
      );
      // turning a string in this format: "HH:mm" to a TimeOfDay entity to
      // use in HabitData entity.
      final reminderTime = habitsDetailsRows[i].reminderTime!.toTimeOfDay();

      // adding to the output list
      out.add(
        HabitData(
          id: Value(habitsDetailsRows[i].habitId),
          currentVersion: Value(habitsDetailsRows[i].version),
          name: Value(habitsDetailsRows[i].name),
          desc: Value(habitsDetailsRows[i].description),
          categoryId: Value(habitsDetailsRows[i].categoryId),
          startDatetime: Value(habitsDetailsRows[i].startDatetime),
          endDatetime: Value(habitsDetailsRows[i].endDatetime),
          reminderTime: Value(reminderTime),
          repeatOnDaysOfWeek: Value(repeatOnDaysOfWeek),
          repeatEveryNDays: Value(habitsDetailsRows[i].repeatEveryNDays),
          targetUnit: Value(habitsDetailsRows[i].targetUnit),
          targetQuantity: Value(habitsDetailsRows[i].targetQuantity),
          goalCompletionRate: Value(habitsDetailsRows[i].goalCompletionRate),
          goalDeadline: Value(habitsDetailsRows[i].goalDeadline),
          isArchived: Value(habitsDetailsRows[i].isArchived),
        ),
      );
    }
    _logger.fine(
      'getAllHabits: Mapped ${out.length} habits to HabitData entities',
    );

    // update cache
    _habitsCache = out.isEmpty ? null : out;
    _logger.fine(
      'getAllHabits: Updated _habitsCache: ${_habitsCache?.length ?? 'null'} items',
    );

    // return the array
    return out.isEmpty ? null : out;
  }

  Future<List<HabitData>?> getTodayHabits() async {
    _logger.fine('getTodayHabits: getTodayHabits called');

    if (_habitsTodayCache != null) {
      _logger.fine(
        'getTodayHabits: Returning cached today habits (${_habitsTodayCache!.length} items)',
      );
      return _habitsTodayCache;
    }

    _logger.fine(
      'getTodayHabits: No today cache available, filtering from all habits',
    );
    final habits = await getAllHabits();
    if (habits == null) {
      _logger.fine('getTodayHabits: No habits available, returning null');
      return null;
    }

    List<HabitData> out = [];
    for (HabitData habit in habits) {
      _logger.finer(
        'getTodayHabits: found habit due today: ${habit.toString()}',
      );
      if (habit.isDueToday()) {
        out.add(habit);
      }
    }
    _logger.fine(
      'getTodayHabits: Found ${out.length} habits due today out of ${habits.length} total habits',
    );

    _habitsTodayCache = out;
    return out.isEmpty ? null : out;
  }

  Future<int?> deleteHabit(int id) async {
    _logger.info('deleteHabit: Starting deleteHabit for ID: $id');

    try {
      final exists =
          await (select(habits)
                ..where((u) => u.isDeleted.equals(false))
                ..where((u) => u.id.equals(id)))
              .getSingleOrNull();
      if (exists != null) {
        _logger.fine('deleteHabit: Habit exists, marking as deleted');
        final habit = await (update(habits)..where((u) => u.id.equals(id)))
            .write(HabitsCompanion(isDeleted: Value(true)));

        // Remove from caches
        if (_habitsCache != null) {
          _habitsCache!.removeWhere((habit) => habit.id.value == id);
          _logger.fine('deleteHabit: Removed habit from _habitsCache');
        }
        if (_habitsTodayCache != null) {
          _habitsTodayCache!.removeWhere((habit) => habit.id.value == id);
          _logger.fine('deleteHabit: Removed habit from _habitsTodayCache');
        }

        _logger.info('deleteHabit: Delete operation completed');
        return habit;
      } else {
        _logger.warning(
          'deleteHabit: Habit with ID $id not found or already deleted',
        );
        return null;
      }
    } catch (e, s) {
      _logger.severe('deleteHabit: Error during deleteHabit', e, s);
      throw Exception(e.toString());
    }
  }

  Future<int?> toggleArchiveHabit(int id) async {
    _logger.info('toggleArchiveHabit: Starting toggleArchiveHabit for ID: $id');

    try {
      final exists =
          await (select(habits)
                ..where((u) => u.isDeleted.equals(false))
                ..where((u) => u.id.equals(id)))
              .getSingleOrNull();
      if (exists == null) {
        _logger.warning('toggleArchiveHabit: Habit with ID $id not found');
        return null;
      }

      final currentVersion =
          await (select(db.habitsDetails)
                ..where((u) => u.habitId.equals(id))
                ..where((u) => u.version.equals(exists.currentVersion)))
              .getSingleOrNull();
      if (currentVersion == null) {
        _logger.severe(
          'toggleArchiveHabit: Current version not found for habit $id',
        );
        throw Exception(
          'Data corruption: current version of this habit doesn\'t exist',
        );
      }

      final Value<bool> newValue = Value(currentVersion.isArchived ^ true);
      _logger.fine(
        'toggleArchiveHabit: Toggling archive status from ${currentVersion.isArchived} to ${newValue.value}',
      );

      return await editHabitDetails(
        HabitData(
          id: Value(id),
          currentVersion: Value(exists.currentVersion),
          name: Value.absent(),
          desc: Value.absent(),
          categoryId: Value.absent(),
          startDatetime: Value.absent(),
          endDatetime: Value.absent(),
          reminderTime: Value.absent(),
          isArchived: newValue,
        ),
      );
    } catch (e, s) {
      _logger.severe(
        'toggleArchiveHabit: Error during toggleArchiveHabit',
        e,
        s,
      );
      throw Exception(e.toString());
    }
  }
}
