import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/database.dart';
import 'package:habit_tracker/core/db/idatabase.dart';

final databaseProvider = FutureProvider.family<Idatabase, bool>((
  ref,
  inMemory,
) async {
  return inMemory
      ? Database(AppDatabase(DatabaseConnection(NativeDatabase.memory())))
      : Database(AppDatabase());
});
