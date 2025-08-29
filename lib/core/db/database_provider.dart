import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/db/database.dart';
import 'package:habit_tracker/core/db/idatabase.dart';

final databaseProvider = FutureProvider.family<Idatabase, bool>((
  ref,
  inMemory,
) async {
  return Database(inMemory: inMemory);
});
