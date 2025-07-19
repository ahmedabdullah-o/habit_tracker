import 'package:drift/drift.dart';
import 'package:habit_tracker/core/enums/db_enums.dart';

class Categories extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().withLength(min: 1, max: 12)();
  late final color = intEnum<CategoriesColor>().withDefault(
    const Constant(0),
  )();
  late final icon = intEnum<CategoriesIcon>().withDefault(const Constant(0))();
}
