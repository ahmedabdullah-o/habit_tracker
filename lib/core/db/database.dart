import 'dart:ui' show Color;

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/days_of_week.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/db/tables/categories.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';
import 'package:habit_tracker/core/db/tables/habits_details.dart';
import 'package:habit_tracker/core/db/tables/habits_log.dart';
import 'package:habit_tracker/core/extensions/habit_data_extensions.dart';
import 'package:habit_tracker/core/extensions/string_extensions.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Habits, HabitsLog, Categories, HabitsDetails])
class Database extends _$Database implements Idatabase {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  List<HabitData>? _habitsCache;
  List<HabitData>? _habitsTodayCache;

  void _validateHabitData(HabitData habitData) async {
    // Check if both repeat options don't equal null
    // or have a value at the same time.
    if ((habitData.repeatEveryNDays.value == null &&
            habitData.repeatOnDaysOfWeek.value == null) ||
        (habitData.repeatEveryNDays.value != null &&
            habitData.repeatOnDaysOfWeek.value != null)) {
      throw Exception(
        'One of the following properties has to have a value and they can\'t both be NULL:\nrepeatOnDaysOfWeek, repeatEveryNDays)',
      );
    }

    if (habitData.goalDeadline.value != null) {
      if (habitData.goalDeadline.value!.isBefore(DateTime.now())) {
        throw Exception('You can\'t set deadline as a time in the past');
      }
    }

    try {
      final categoryExists =
          await (select(categories)
                ..where((tbl) => tbl.id.equals(habitData.categoryId.value)))
              .getSingleOrNull();

      if (categoryExists == null) {
        throw Exception('No category exists with the given ID.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<int?> insertHabit(HabitData habitData) async {
    // throws exception if something is wrong with the data
    _validateHabitData(habitData);

    // gotta make sure id & currentVersion aren't assigned manually
    if (habitData.id != Value.absent() ||
        habitData.currentVersion != Value.absent()) {
      throw Exception(
        '`HabitData().id` & `HabitData().currentVersion` must be absent (e.g. equal `Value.absent()`)',
      );
    }

    final reminderTime =
        "${habitData.reminderTime.value.hour.toString().padLeft(2, '0')}:${habitData.reminderTime.value.minute..toString().padLeft(2, '0')}";

    try {
      transaction(() async {
        final habit = await into(habits).insert(
          HabitsCompanion.insert(
            id: Value.absent(),
            currentVersion: Value(1),
            // TODO: googleSub = API request / shared_pref fetch data
            createdAt: Value(DateTime.now()),
            isDeleted: Value(false),
          ),
        );

        into(habitsDetails).insert(
          HabitsDetailsCompanion.insert(
            id: Value.absent(),
            habitId: habit,
            version: Value(1),
            editDatetime: Value(DateTime.now()),
            name: habitData.name.toString(),
            description: habitData.desc.value,
            categoryId: habitData.categoryId as int,
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
        if (_habitsCache != null) {
          for (int i = 0; i < _habitsCache!.length; i++) {
            if (_habitsCache![i].reminderTime.value.isAfter(
              habitData.reminderTime.value,
            )) {
              _habitsCache!.insert(i, habitData);
            }
          }
        } else {
          _habitsCache = [habitData];
        }
        return habit;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Future<int?> editHabitDetails(HabitData newDetails) async {
    _validateHabitData(newDetails);

    if (newDetails.id == Value.absent() ||
        newDetails.currentVersion == Value.absent()) {
      throw Exception(
        'Can\'t edit a habit with undefined id or currentVersion. these fields should be already assigned by the query method and should NOT be assigned or modified manually.',
      );
    }

    final newVersionNum = Value(newDetails.currentVersion.value + 1);

    final reminderTime =
        "${newDetails.reminderTime.value.hour.toString().padLeft(2, '0')}:${newDetails.reminderTime.value.minute..toString().padLeft(2, '0')}";

    try {
      transaction(() async {
        (update(habits)..where((tbl) => tbl.id.equals(newDetails.id.value)))
            .write(HabitsCompanion(currentVersion: newVersionNum));

        (into(habitsDetails).insert(
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
        for (HabitData habit in _habitsCache!) {
          if (habit.id.value == newDetails.id.value) {
            habit = newDetails;
            break;
          }
        }
        return newVersionNum.value;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Future<List<HabitData>?> getAllHabits() async {
    // check if there's an available cache to return
    if (_habitsCache != null) {
      return _habitsCache;
    }

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

      // extracting id column for habits_details query
      habitIds = habitsRows.map((row) => row.id).toList();

      // query habits_details table
      habitsDetailsRows =
          await (select(habitsDetails)
                // querying details for only undeleted habits
                ..where((tbl) => tbl.habitId.isIn(habitIds)))
              .get();
    } catch (e) {
      throw Exception(e.toString());
    }
    final latestDetailsMap = <int, HabitsDetail>{};

    // grouping latest details only into latestDetailsMap.
    for (final detail in habitsDetailsRows) {
      final existing = latestDetailsMap[detail.habitId];
      if (existing == null || detail.version > existing.version) {
        latestDetailsMap[detail.habitId] = detail;
      }
    }

    // replacing with only the latest details
    habitsDetailsRows.clear();
    habitsDetailsRows.addAll(latestDetailsMap.values.toList());

    // mapping to HabitData entities for output
    final List<HabitData> out = [];

    for (int i = 0; i < habitsDetailsRows.length; i++) {
      // parsing to valid types
      final repeatOnDaysOfWeek = DaysOfWeek.parseFromDB(
        habitsDetailsRows[i].repeatOnDaysOfWeek,
      );
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
    // update cache
    _habitsCache = out.isEmpty ? null : out;
    // return the array
    return out.isEmpty ? null : out;
  }

  @override
  Future<List<HabitData>?> getTodayHabits() async {
    if (_habitsTodayCache != null) {
      return _habitsTodayCache;
    }
    final habits = await getAllHabits();
    if (habits == null) {
      return null;
    }
    List<HabitData> out = [];
    for (HabitData habit in habits) {
      if (habit.isDueToday()) {
        out.add(habit);
      }
    }
    _habitsTodayCache = out;
    return out.isEmpty ? null : out;
  }

  @override
  Future<int?> insertCategory(CategoryData categoryData) async {
    if (categoryData.id != Value.absent()) {
      throw Exception(
        'the property CategoryData.id should be unassigned in case of insertion',
      );
    }
    try {
      int? insertId;
      final duplicate =
          await (select(categories)
                ..where(
                  (u) => u.color.equals(categoryData.color.value.toARGB32()),
                )
                ..where(
                  (u) =>
                      u.iconCodePoint.equals(categoryData.iconCodePoint.value),
                ))
              .getSingleOrNull();
      if (duplicate == null) {
        insertId = await into(categories).insert(
          CategoriesCompanion.insert(
            name: categoryData.name.value,
            color: categoryData.color.value.toARGB32(),
            iconCodePoint: categoryData.iconCodePoint.value,
          ),
        );
      }
      return insertId;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(databaseDirectory: getLibraryDirectory),
    );
  }
}
