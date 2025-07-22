import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/tables/habits.dart';
import 'package:habit_tracker/core/db/tables/habits_details.dart';

@TableIndex(
  name: 'habit_log_creation_time_idx',
  columns: {#habit, #logDatetime},
)
class HabitsLog extends Table {
  late final id = integer().autoIncrement()(),
      habit = integer().references(Habits, #id)(),
      habitsDetailsVersion = integer().references(HabitsDetails, #version)(),
      logDatetime = dateTime().withDefault(currentDateAndTime)(),
      state = real().withDefault(const Constant(0))();
}
