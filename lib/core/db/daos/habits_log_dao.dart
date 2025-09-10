import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/tables/habits_log.dart';
import 'package:habit_tracker/core/entities/log_data.dart';

part 'habits_log_dao.g.dart';

@DriftAccessor(tables: [HabitsLog])
class HabitsLogDao extends DatabaseAccessor<AppDatabase>
    with _$HabitsLogDaoMixin {
  HabitsLogDao(super.db);

  Future<int?> insertLog(LogData logData) async {
    final habitQuery =
        await (select(db.habits)
              ..where((u) => u.id.equals(logData.habitId.value))
              ..where((u) => u.isDeleted.equals(false)))
            .getSingleOrNull();

    if (habitQuery == null) {
      return null;
    }

    int currentVersion = habitQuery.currentVersion;

    int op = await into(db.habitsLog).insert(
      HabitsLogCompanion.insert(
        habitId: logData.habitId.value,
        habitDetailsVersion: currentVersion,
        logDatetime: logData.datetime,
        state: logData.state,
      ),
    );
    return op;
  }

  Future<Map<int, List<LogData>>> getLog(List<int> habitIds) async {
    try {
      final query = await (db.select(
        habitsLog,
      )..where((u) => u.habitId.isIn(habitIds))).get();
      Map<int, List<LogData>> out = {};
      for (final item in query) {
        if (out[item.habitId] == null) out[item.habitId] = [];
        out[item.habitId]!.add(
          LogData(
            habitId: Value(item.habitId),
            habitDetailsVersion: Value(item.habitDetailsVersion),
            state: Value(item.state),
            datetime: Value(item.logDatetime),
          ),
        );
      }
      return out;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
