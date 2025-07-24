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

  void _validateForInsert(HabitData habitData) async {
    if (habitData.id != null) {
      throw Exception(
        'Don\'t manually set IDs. This property is preserved for queries.',
      );
    }

    // Check if both repeat options don't equal null
    // or have a value at the same time.
    if ((habitData.repeatEveryNDays == null &&
            habitData.repeatOnDaysOfWeek == null) ||
        (habitData.repeatEveryNDays != null &&
            habitData.repeatOnDaysOfWeek != null)) {
      throw Exception(
        'One of the following properties has to have a value and they can\'t both be NULL:\nrepeatOnDaysOfWeek, repeatEveryNDays)',
      );
    }

    if (habitData.goalDeadline != null) {
      if (habitData.goalDeadline!.isBefore(DateTime.now())) {
        throw Exception('You can\'t set deadline as a time in the past');
      }
    }

    {
      final categoryExists = await (select(
        categories,
      )..where((tbl) => tbl.id.equals(habitData.categoryId))).getSingleOrNull();

      if (categoryExists == null) {
        throw Exception('No category exists with the given ID.');
      }
    }
  }

  @override
  Future<int> insertHabit(HabitData habitData) async {
    // throws exception if something is wrong with the data
    _validateForInsert(habitData);

    final reminderTime =
        "${habitData.reminderTime.hour.toString().padLeft(2, '0')}:${habitData.reminderTime.minute.toString().padLeft(2, '0')}";
    final habit = await into(habits).insert(
      HabitsCompanion.insert(
        // TODO: googleSub = API request / shared_pref fetch data
      ),
    );

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
        repeatOnDaysOfWeek: Value(habitData.repeatOnDaysOfWeek?.toDBFormat()),
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
