import 'package:drift/drift.dart';

class Habits extends Table {
  late final id = integer().autoIncrement()(),
      googleUserId = text().nullable()(),
      createdAt = dateTime()(),
      isDeleted = boolean().withDefault(const Constant(false))();
}
