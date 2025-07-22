import 'package:drift/drift.dart';

class Categories extends Table {
  late final id = integer().autoIncrement()(),
      name = text().withLength(min: 1, max: 12)(),
      /// example 'FFFFFF'
      colorHex = text().withLength(
        min: 6,
        max: 6,
      )(),
      iconCodePoint = integer()();
}
