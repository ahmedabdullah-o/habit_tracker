import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/core/db/database_provider.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:logging/logging.dart';

void main() async {
  ProviderContainer providerContainer = ProviderContainer();
  Idatabase? database;

  setUpAll(() async {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.loggerName}: ${record.message}');
      }
    });
  });

  setUp(() async {
    database = await providerContainer.read(databaseProvider(true).future);
  });

  tearDown(() async {
    await database!.close();
    providerContainer.invalidate(databaseProvider);
  });

  group('Drift Database Test -', () {
    group('Categories Table -', () {
      test('when a category is inserted rowId should be returned', () async {
        final categoryData = CategoryData(
          name: Value('test'),
          color: Value(Colors.black),
          iconCodePoint: Value(23),
        );
        int? rowId = await database!.insertCategory(categoryData);
        expect(rowId, isPositive);
      });
      test(
        'when row is inserted getAllCategories() should return it',
        () async {
          final categoryData = CategoryData(
            name: Value('test'),
            color: Value(Colors.black),
            iconCodePoint: Value(23),
          );
          await database!.insertCategory(categoryData);
          List<CategoryData>? query = await database!.getAllCategories();
          expect(query?.length ?? 0, 1);
          expect(query![0].name, categoryData.name);
          expect(query[0].color, categoryData.color);
          expect(query[0].iconCodePoint, categoryData.iconCodePoint);
        },
      );
      test(
        'test insertCategory() & getAllCategories() with multiple inserts',
        () async {
          List<CategoryData> categories = [
            CategoryData(
              name: Value('cat1'),
              color: Value(Colors.black),
              iconCodePoint: Value(23),
            ),
            CategoryData(
              name: Value('cat2'),
              color: Value(Colors.deepOrange),
              iconCodePoint: Value(15),
            ),
            CategoryData(
              name: Value('cat1'),
              color: Value(Colors.pink),
              iconCodePoint: Value(1),
            ),
          ];
          for (final category in categories) {
            await database!.insertCategory(category);
          }
          final query = await database!.getAllCategories();
          expect(query!.length, 3);
        },
      );
    });
    group('Habits Table -', () {
      test('habits table should be empty by default', () async {
        final query = await database!.getAllHabits();
        expect(query, null);
      });
      test('when a habit is inserted the rowId should be returned', () async {
        final categoryData = CategoryData(
          name: Value('CategName'),
          color: Value(Colors.purple),
          iconCodePoint: Value(23),
        );
        final categoryId = await database!.insertCategory(categoryData);
        final habitData = HabitData(
          name: Value('name'),
          desc: Value('desc'),
          categoryId: Value(categoryId!),
          startDatetime: Value(DateTime.now()),
          endDatetime: Value(null),
          reminderTime: Value(TimeOfDay.now()),
          repeatEveryNDays: Value(2),
        );
        final val = await database!.insertHabit(habitData);
        expect(val, isNotNaN);
      });
      test(
        'when row is inserted should getAllHabits() should return it',
        () async {
          final categoryData = CategoryData(
            name: Value('CategName'),
            color: Value(Colors.purple),
            iconCodePoint: Value(23),
          );
          final categoryId = await database!.insertCategory(categoryData);
          final habitData = HabitData(
            name: Value('name'),
            desc: Value('desc'),
            categoryId: Value(categoryId!),
            startDatetime: Value(DateTime.now()),
            endDatetime: Value(null),
            reminderTime: Value(TimeOfDay.now()),
            repeatEveryNDays: Value(2),
          );
          final val = await database!.insertHabit(habitData);
          expect(val, isNotNaN);
          expect((await database!.getAllHabits())?.length ?? 0, 1);
        },
      );
      test(
        'testing insertHabit() & getAllHabits() with multiple inserts',
        () async {
          final categoryData = CategoryData(
            name: Value('CategName'),
            color: Value(Colors.purple),
            iconCodePoint: Value(23),
          );
          final categoryId = await database!.insertCategory(categoryData);
          List<HabitData> habits = [
            HabitData(
              name: Value('habit 1'),
              desc: Value('description 1'),
              categoryId: Value(categoryId!),
              startDatetime: Value(DateTime.now()),
              endDatetime: Value(null),
              reminderTime: Value(TimeOfDay.now()),
              repeatEveryNDays: Value(3),
            ),
            HabitData(
              name: Value('habit 2'),
              desc: Value('description 2'),
              categoryId: Value(categoryId),
              startDatetime: Value(DateTime.now()),
              endDatetime: Value(null),
              reminderTime: Value(TimeOfDay.now()),
              repeatEveryNDays: Value(2),
            ),
            HabitData(
              name: Value('habit 3'),
              desc: Value('description 3'),
              categoryId: Value(categoryId),
              startDatetime: Value(DateTime.now()),
              endDatetime: Value(null),
              reminderTime: Value(TimeOfDay.now()),
              repeatEveryNDays: Value(1),
            ),
          ];
          for (final habit in habits) {
            await database!.insertHabit(habit);
          }
          final query = await database!.getAllHabits();
          expect(query!.length, 3);
        },
      );
    });
  });
}
