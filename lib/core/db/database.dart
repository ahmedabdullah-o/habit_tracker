// ignore_for_file: unused_import

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:habit_tracker/core/db/tables/categories.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';
import 'package:habit_tracker/core/db/tables/habits_details.dart';
import 'package:habit_tracker/core/db/tables/habits_log.dart';
import 'package:path_provider/path_provider.dart';

// transitive
import 'package:habit_tracker/core/enums/db_enums.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Habits, HabitsLog, Categories, HabitsDetails])
class Database extends _$Database {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(databaseDirectory: getLibraryDirectory),
    );
  }
}
