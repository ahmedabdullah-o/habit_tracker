import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';

abstract class Idatabase {
  /// Returns the habit row id.
  Future<int?> insertHabit(HabitData habitData);

  /// Returns the latest version of the entity `Habit`.
  Future<int?> editHabitDetails(HabitData habitData);

  /// Returns all undeleted habits.
  Future<List<HabitData>?> getAllHabits();

  /// Returns habits due today.
  Future<List<HabitData>?> getTodayHabits();

  /// Inserts a new category into the database.
  /// If null is returned that means a category with the exact properties already exists.
  Future<int?> insertCategory(CategoryData categoryData);
}
