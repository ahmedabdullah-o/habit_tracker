import 'package:habit_tracker/core/db/database.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';

abstract class Idatabase {
  /// Returns the habit row id
  Future<int> insertHabit(HabitData habitData);
  void editHabitDetails();
  Habit? queryHabit();
}
