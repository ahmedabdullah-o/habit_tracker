import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/entities/log_data.dart';

abstract class Idatabase {
  /// Closes the DB :)
  Future<void> close();

  /// Returns the habit row id.
  Future<int?> insertHabit(HabitData habitData);

  /// Returns the latest version of the entity `Habit`.
  Future<int?> editHabitDetails(HabitData newData);

  /// Returns all undeleted habits.
  Future<List<HabitData>?> getAllHabits();

  /// Returns habits due today.
  Future<List<HabitData>?> getTodayHabits();

  /// Returns the id of the deleted habit
  ///
  /// if null is returned then there is no such **undeleted** habit with this id.
  ///
  /// **NOTE**: deleted habits are soft deleted, meaning they persist in the database but marked as deleted.
  Future<int?> deleteHabit(int id);

  /// Return the id of the archived/unarchived habit
  ///
  /// if null is returned then there is no such **undeleted** habit with this id.
  ///
  /// **NOTE**: deleted habits are soft deleted, meaning they persist in the database but marked as deleted.
  Future<int?> toggleArchiveHabit(int id);

  /// Returns the id of the log
  ///
  /// if null is returned then there is no such **undeleted** habit with this id.
  Future<int?> logHabit(LogData logData);

  /// Return a map with the habitId as the key and a list of LogData objects as the value.
  Future<Map<int, List<LogData>>?> getLog(List<int> habitIds);

  /// Inserts a new category into the database.
  ///
  /// If null is returned that means a category with the exact properties already exists.
  Future<int?> insertCategory(CategoryData categoryData);

  /// Returns the category with the corresponding id
  ///
  /// if null is returned then there is no category with the given id
  Future<CategoryData?> getCategory(int id);

  /// Returns all the previously inserted categories
  ///
  /// if null is returned then there are no categories
  Future<List<CategoryData>?> getAllCategories();

  /// Returns the id of the edited category or null if the category doesn't exist
  Future<int?> editCategory(CategoryData newData);
}
