import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/core/db/database_provider.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/entities/log_data.dart';
import 'package:logging/logging.dart';

void main() async {
  ProviderContainer providerContainer = ProviderContainer();
  Idatabase? database;

  setUpAll(() async {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        debugPrint(
          '${record.level.name}: ${record.loggerName}: ${record.message}',
        );
        if (record.error != null) {
          debugPrint('${record.error}\n${record.stackTrace}');
        }
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

  group('Drift Database Test', () {
    group('Categories Table', () {
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
    group('Habits & Habits Details Table', () {
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
      test(
        'editHabit() should not change the id, or absent values, but only change assigned properties.',
        () async {
          final categoryData = CategoryData(
            name: Value('CategName'),
            color: Value(Colors.purple),
            iconCodePoint: Value(23),
          );

          final categoryId = await database!.insertCategory(categoryData);

          final habit = HabitData(
            name: Value('habit'),
            desc: Value('before edit'),
            categoryId: Value(categoryId!),
            startDatetime: Value(DateTime.now()),
            endDatetime: Value(null),
            reminderTime: Value(TimeOfDay.now()),
            repeatEveryNDays: Value(1),
          );

          final habitId = await database!.insertHabit(habit);

          final queryBefore = await database!.getAllHabits();

          HabitData newData = queryBefore![0];

          newData.desc = Value('after edit');

          await database!.editHabitDetails(newData);

          final queryAfter = (await database!.getAllHabits())![0];

          expect(queryAfter.id.value, habitId);
          expect(queryAfter.name.value, 'habit');
          expect(queryAfter.desc.value, 'after edit');
        },
      );
      test('getTodayHabit() should only return habits due today', () async {
        final categoryData = CategoryData(
          name: Value('CategName'),
          color: Value(Colors.purple),
          iconCodePoint: Value(23),
        );

        final categoryId = await database!.insertCategory(categoryData);

        final habit = [
          HabitData(
            name: Value('due today'),
            desc: Value('desc'),
            categoryId: Value(categoryId!),
            startDatetime: Value(DateTime.now()),
            endDatetime: Value(null),
            reminderTime: Value(TimeOfDay.now()),
            repeatEveryNDays: Value(1),
          ),
          HabitData(
            name: Value('due tomorrow'),
            desc: Value('desc'),
            categoryId: Value(categoryId),
            startDatetime: Value(DateTime.now().add(Duration(days: 1))),
            endDatetime: Value(null),
            reminderTime: Value(TimeOfDay.now()),
            repeatEveryNDays: Value(1),
          ),
        ];
        await database!.insertHabit(habit[0]);
        await database!.insertHabit(habit[1]);
        final query = await database!.getTodayHabits();
        expect(query!.length, 1);
        expect(query[0].name.value, 'due today');
      });
      test(
        'when insert 2 habits and delete 1 using deleteHabit(), one habit should be remaining in the database',
        () async {
          final categoryData = CategoryData(
            name: Value('CategName'),
            color: Value(Colors.purple),
            iconCodePoint: Value(23),
          );

          final categoryId = await database!.insertCategory(categoryData);

          final habit = [
            HabitData(
              name: Value('dont delete'),
              desc: Value('desc'),
              categoryId: Value(categoryId!),
              startDatetime: Value(DateTime.now()),
              endDatetime: Value(null),
              reminderTime: Value(TimeOfDay.now()),
              repeatEveryNDays: Value(1),
            ),
            HabitData(
              name: Value('delete'),
              desc: Value('desc'),
              categoryId: Value(categoryId),
              startDatetime: Value(DateTime.now().add(Duration(days: 1))),
              endDatetime: Value(null),
              reminderTime: Value(TimeOfDay.now()),
              repeatEveryNDays: Value(1),
            ),
          ];
          await database!.insertHabit(habit[0]);
          final habitId = await database!.insertHabit(habit[1]);
          final deleteQuery = await database!.deleteHabit(habitId!);
          expect(deleteQuery, isPositive);
          final selectQuery = await database!.getAllHabits();
          expect(selectQuery!.length, 1);
          expect(selectQuery[0].name.value, 'dont delete');
        },
      );
      test('habit.isArchived should be false by default', () async {
        final categoryData = CategoryData(
          name: Value('CategName'),
          color: Value(Colors.purple),
          iconCodePoint: Value(23),
        );

        final categoryId = await database!.insertCategory(categoryData);

        final habit = HabitData(
          name: Value('habit'),
          desc: Value('before edit'),
          categoryId: Value(categoryId!),
          startDatetime: Value(DateTime.now()),
          endDatetime: Value(null),
          reminderTime: Value(TimeOfDay.now()),
          repeatEveryNDays: Value(1),
        );
        await database!.insertHabit(habit);
        final query = await database!.getAllHabits();
        expect(query![0].isArchived.value, false);
      });
      test(
        'toggleArchiveHabit() should flip habit.isArchived in cache and database',
        () async {
          final categoryData = CategoryData(
            name: Value('CategName'),
            color: Value(Colors.purple),
            iconCodePoint: Value(23),
          );

          final categoryId = await database!.insertCategory(categoryData);

          final habit = HabitData(
            name: Value('habit'),
            desc: Value('desc'),
            categoryId: Value(categoryId!),
            startDatetime: Value(DateTime.now()),
            endDatetime: Value(null),
            reminderTime: Value(TimeOfDay.now()),
            repeatEveryNDays: Value(1),
          );
          final habitId = await database!.insertHabit(habit);
          {
            await database!.toggleArchiveHabit(habitId!);
            final query = await database!.getAllHabits();
            expect(query![0].isArchived.value, true);
          }
          {
            await database!.toggleArchiveHabit(habitId);
            final query = await database!.getAllHabits();
            expect(query![0].isArchived.value, false);
          }
        },
      );
    });
    group('Habits Log Table', () {
      test('test insertLog()', () async {
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
        final habitId = await database!.insertHabit(habitData);
        await database!.logHabit(
          LogData(
            habitId: Value(habitId!),
            state: Value(1),
            habitDetailsVersion: Value(1),
          ),
        );
        habitData.id = Value(habitId);
        habitData.currentVersion = Value(1);
        final query = await database!.getLog([habitData.id.value]);
        expect(query!.length, 1);
        expect(query[1]!.length, 1);
        expect(query[1]![0].habitId.value, 1);
        expect(query[1]![0].habitDetailsVersion.value, 1);
        expect(query[1]![0].state.value, 1.0);
      });
      test('test insertLog() with multiple inserts', () async {
        final categoryData = CategoryData(
          name: Value('CategName'),
          color: Value(Colors.purple),
          iconCodePoint: Value(23),
        );
        final categoryId = await database!.insertCategory(categoryData);
        final habitData = HabitData(
          name: Value('habit 1'),
          desc: Value('desc'),
          categoryId: Value(categoryId!),
          startDatetime: Value(DateTime.now()),
          endDatetime: Value(null),
          reminderTime: Value(TimeOfDay.now()),
          repeatEveryNDays: Value(2),
        );
        final habitId = await database!.insertHabit(habitData);
        await database!.logHabit(
          LogData(
            habitId: Value(habitId!),
            habitDetailsVersion: Value(1),
            state: Value(1.0),
          ),
        );
        await database!.logHabit(
          LogData(
            habitId: Value(habitId),
            habitDetailsVersion: Value(1),
            state: Value(4.5),
          ),
        );
        await database!.logHabit(
          LogData(
            habitId: Value(habitId),
            habitDetailsVersion: Value(1),
            state: Value(0.0),
          ),
        );
        final query = await database!.getLog([habitId]);
        expect(query![1]!.length, 3);
      });
    });
  });
}
