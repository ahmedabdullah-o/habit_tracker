import 'package:habit_tracker/core/entities/habit_data.dart';

abstract class Idatabase {
  /// Returns the habit row id.
  Future<int?> insertHabit(HabitData habitData);
  /// Returns the latest version of the entity `Habit`.
  Future<int?> editHabitDetails(HabitData habitData);
  /// Returns habits due today.
  Future<List<HabitData>?> getTodayHabits();
}
