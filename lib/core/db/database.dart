import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:habit_tracker/core/db/entities/habit_data.dart';
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

  @override
  Future<int> insertHabit(HabitData habitData) async {
    final reminderTime =
        "${habitData.reminderTime.hour.toString().padLeft(2, '0')}:${habitData.reminderTime.minute.toString().padLeft(2, '0')}";
    final habit = await into(habits).insert(HabitsCompanion.insert(
      // TODO: googleSub = API request / shared_pref fetch data
    ));
    into(habitsDetails).insert(
      HabitsDetailsCompanion.insert(
        habitId: habit,
        version: Value(1),
        editDatetime: Value(DateTime.now()),
        name: habitData.name,
        description: Value(habitData.desc),
        categoryId: habitData.categoryId,
        startDatetime: habitData.startDatetime,
        endDatetime: Value(habitData.endDatetime),
        reminderTime: Value(reminderTime),
        // TODO: repeatOnDaysOfWeek;
        repeatEveryNDays: Value(habitData.repeatEveryNDays),
        targetUnit: Value(habitData.targetUnit),
        targetQuantity: Value(habitData.targetQuantity),
        goalCompletionRate: Value(habitData.goalCompletionRate),
        goalDeadline: Value(habitData.goalDeadline),
        isArchived: Value(habitData.isArchived),
      ),
    );
    return habit;
  }

  @override
  void editHabitDetails() {}
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
