import 'package:drift/drift.dart';

class Categories extends Table {
  late final id = integer().autoIncrement()(),
      name = text().withLength(min: 1, max: 12)(),
      color = integer()(),
      iconCodePoint = integer()();
}
