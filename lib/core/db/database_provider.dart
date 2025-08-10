import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/database.dart';
import 'package:habit_tracker/core/db/idatabase.dart';

final databaseProvider = Provider<Idatabase>((ref) {
  return Database(AppDatabase());
});
