import 'dart:io';

import 'package:drift/native.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/entities/log_data.dart';
import 'package:path_provider/path_provider.dart';

class Database implements Idatabase {
  final bool inMemory;
  Database({this.inMemory = false});

  bool _isInitialized = false;
  late final AppDatabase db;

  Future<void> _initializeDB(bool inMemory) async {
    db = inMemory
        ? AppDatabase(NativeDatabase.memory())
        : AppDatabase(
            NativeDatabase(
              File("${(await getApplicationDocumentsDirectory()).path}/app.db"),
            ),
          );
    _isInitialized = true;
  }

  // @override
  // Future<void> clearMemory() async {
  //   if (!inMemory) {
  //     throw Exception(
  //       'You\'re using clearMemory() with a non-in-memory database',
  //     );
  //   }
  //   if (!_isInitialized) {
  //     await _initializeDB(inMemory);
  //   }
  //   await db.close();
  //   db = AppDatabase(NativeDatabase.memory());
  // }

  @override
  Future<void> close() async {
    return await db.close();
  }

  @override
  Future<int?> insertHabit(HabitData habitData) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsDao.insertHabit(habitData);
  }

  @override
  Future<int?> editHabitDetails(HabitData newData) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsDao.editHabitDetails(newData);
  }

  @override
  Future<List<HabitData>?> getAllHabits() async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsDao.getAllHabits();
  }

  @override
  Future<List<HabitData>?> getTodayHabits() async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsDao.getTodayHabits();
  }

  @override
  Future<int?> deleteHabit(int id) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsDao.deleteHabit(id);
  }

  @override
  Future<int?> toggleArchiveHabit(int id) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsDao.toggleArchiveHabit(id);
  }

  @override
  Future<int?> logHabit(LogData logData) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsLogDao.insertLog(logData);
  }

  @override
  Future<Map<int, List<LogData>>?> getLog(List<int> habitIds) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.habitsLogDao.getLog(habitIds);
  }

  @override
  Future<int?> insertCategory(CategoryData categoryData) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.categoriesDao.insertCategory(categoryData);
  }

  @override
  Future<CategoryData?> getCategory(int id) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.categoriesDao.getCategory(id);
  }

  @override
  Future<List<CategoryData>?> getAllCategories() async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.categoriesDao.getAllCategories();
  }

  @override
  Future<int?> editCategory(CategoryData newData) async {
    if (!_isInitialized) {
      await _initializeDB(inMemory);
    }
    return await db.categoriesDao.editCategory(newData);
  }
}
