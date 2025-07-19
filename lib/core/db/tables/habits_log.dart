import 'package:drift/drift.dart';
import 'package:habit_tracker/core/enums/db_enums.dart';

@TableIndex(name: 'habit_log_creation_time_idx', columns: {#habit, #datetime})
class HabitsLog extends Table {
  late final id = integer().autoIncrement()();
  late final habit = integer().references(Habits, #id)();
  late final creationDatetime = dateTime().withDefault(currentDateAndTime)();

  /// Default value is 3 (none).
  late final state = intEnum<HabitsLogState>().withDefault(const Constant(3))();
}
