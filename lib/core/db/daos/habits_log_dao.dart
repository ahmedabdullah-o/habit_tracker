import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/tables/habits_log.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
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
        habitsDetailsVersion: currentVersion,
        state: logData.state,
      ),
    );
    return op;
  }

  Future<Map<int, List<Map<DateTime, double?>>>> getLog(
    List<HabitData> habits,
  ) async {
    List<int> habitsIds = habits.map((row) => row.id.value).toList();

    try {
      final query = await (db.select(
        habitsLog,
      )..where((u) => u.habitId.isIn(habitsIds))).get();
      Map<int, List<Map<DateTime, double?>>> out = {};
      for (final item in query) {
        if (!out.containsKey(item.habitId)) {
          out[item.habitId] = [];
        }
        out[item.habitId]!.add({item.logDatetime: item.state});
      }
      return out;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
