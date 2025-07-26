import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/db/tables/categories.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';
import 'package:habit_tracker/core/db/tables/habits_details.dart';
import 'package:habit_tracker/core/db/tables/habits_log.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Habits, HabitsLog, Categories, HabitsDetails])
class Database extends _$Database implements Idatabase {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// `checkId` whether to check if the id is absent or not, which is required when inserting rows.
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

    // gotta make sure the id isn't assigned manually
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
            description: habitData.desc,
            categoryId: habitData.categoryId as int,
            startDatetime: habitData.startDatetime.value,
            endDatetime: habitData.endDatetime,
            reminderTime: Value(reminderTime),
            repeatOnDaysOfWeek: Value(
              habitData.repeatOnDaysOfWeek.value?.toDBFormat(),
            ),
            repeatEveryNDays: habitData.repeatEveryNDays,
            targetUnit: habitData.targetUnit,
            targetQuantity: habitData.targetQuantity,
            goalCompletionRate: habitData.goalCompletionRate,
            goalDeadline: habitData.goalDeadline,
            isArchived: habitData.isArchived,
          ),
        );
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
            description: newDetails.desc,
            categoryId: newDetails.categoryId.value,
            startDatetime: newDetails.startDatetime.value,
            endDatetime: newDetails.endDatetime,
            reminderTime: Value(reminderTime),
            repeatEveryNDays: newDetails.repeatEveryNDays,
            repeatOnDaysOfWeek: Value(
              newDetails.repeatOnDaysOfWeek.value?.toDBFormat(),
            ),
            targetUnit: newDetails.targetUnit,
            targetQuantity: newDetails.targetQuantity,
            goalCompletionRate: newDetails.goalCompletionRate,
            goalDeadline: newDetails.goalDeadline,
            isArchived: newDetails.isArchived,
          ),
        ));
        return newVersionNum.value;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Habit? queryHabit() {
    return null;
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
