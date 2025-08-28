import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/entities/log_data.dart';

class Database implements Idatabase {
  final AppDatabase db;
  Database(this.db);

  @override
  Future<void> open() {
    // TODO: implement open
    throw UnimplementedError();
  }

  @override
  Future<void> close() async {
    return await db.close();
  }

  @override
  Future<int?> insertHabit(HabitData habitData) {
    return db.habitsDao.insertHabit(habitData);
  }

  @override
  Future<int?> editHabitDetails(HabitData newData) {
    return db.habitsDao.editHabitDetails(newData);
  }

  @override
  Future<List<HabitData>?> getAllHabits() {
    return db.habitsDao.getAllHabits();
  }

  @override
  Future<List<HabitData>?> getTodayHabits() {
    return db.habitsDao.getTodayHabits();
  }

  @override
  Future<int?> deleteHabit(int id) {
    return db.habitsDao.deleteHabit(id);
  }

  @override
  Future<int?> toggleArchiveHabit(int id) {
    return db.habitsDao.toggleArchiveHabit(id);
  }

  @override
  Future<int?> logHabit(LogData logData) {
    return db.habitsLogDao.insertLog(logData);
  }

  @override
  Future<Map<int, List<Map<DateTime, double?>>>> getLog(
    List<HabitData> habits,
  ) {
    return db.habitsLogDao.getLog(habits);
  }

  @override
  Future<int?> insertCategory(CategoryData categoryData) {
    return db.categoriesDao.insertCategory(categoryData);
  }

  @override
  Future<CategoryData?> getCategory(int id) {
    return db.categoriesDao.getCategory(id);
  }

  @override
  Future<List<CategoryData>?> getAllCategories() {
    return db.categoriesDao.getAllCategories();
  }

  @override
  Future<int?> editCategory(CategoryData newData) {
    return db.categoriesDao.editCategory(newData);
  }
}
