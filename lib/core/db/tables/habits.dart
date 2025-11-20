import 'package:drift/drift.dart';

class Habits extends Table {
  late final id = integer().autoIncrement()(),
      currentVersion = integer().withDefault(const Constant(1))(),
      googleSub = text().nullable()(),
      createdAt = dateTime().withDefault(currentDateAndTime)(),
      isDeleted = boolean().withDefault(const Constant(false))();
}
