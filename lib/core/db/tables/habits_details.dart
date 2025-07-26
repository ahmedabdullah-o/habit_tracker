import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/tables/categories.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';

class HabitsDetails extends Table {
  late final id = integer().autoIncrement()(),
      habitId = integer().references(Habits, #id)(),
      version = integer().withDefault(const Constant(1))(),
      editDatetime = dateTime().withDefault(currentDateAndTime)(),
      name = text()(),
      description = text().nullable()(),
      categoryId = integer().references(Categories, #id)(),
      startDatetime = dateTime()(),
      endDatetime = dateTime().nullable()(),
      reminderTime = text().nullable()(),
      repeatOnDaysOfWeek = text().nullable()(),
      repeatEveryNDays = integer().nullable()(),
      targetUnit = text().nullable()(),
      targetQuantity = real().nullable()();
  late final Column<int> goalCompletionRate = integer()
      .check(goalCompletionRate.isBetweenValues(50, 100))
      .nullable()();
  late final goalDeadline = dateTime().nullable()(),
      isArchived = boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {habitId, version},
  ];
}
