import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/daos/categories_dao.dart';
import 'package:habit_tracker/core/db/daos/habits_dao.dart';
import 'package:habit_tracker/core/db/daos/habits_log_dao.dart';
import 'package:habit_tracker/core/db/tables/categories.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';
import 'package:habit_tracker/core/db/tables/habits_details.dart';
import 'package:habit_tracker/core/db/tables/habits_log.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Habits, HabitsLog, Categories, HabitsDetails],
  daos: [HabitsDao, CategoriesDao, HabitsLogDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
