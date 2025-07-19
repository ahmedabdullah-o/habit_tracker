import 'package:drift/drift.dart';

class Habits extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().withLength(min: 1, max: 30)();
  late final description = text().nullable()();
  late final startDatetime = dateTime()();
  late final endDatetime = dateTime().nullable()();

  /// Stored as 'HH:mm' string.
  late final reminderTime = text().nullable()();

  /// Format: '1111111' referring to days of the week (sun, mon, tue... sat).
  late final repeatDayOfWeek = text().withLength(min: 7, max: 7)();
  late final categoryId = integer().references(Categories, #id)();
  late final createdAt = dateTime()();
  late final changedAt = dateTime()();
  late final isArchived = boolean().withDefault(const Constant(false))();
  late final isDeleted = boolean().withDefault(const Constant(false))();
}
