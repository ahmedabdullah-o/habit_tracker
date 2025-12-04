import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/entities/category_data.dart';
import 'package:habit_tracker/core/entities/days_of_week.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';

extension HabitDataExtensions on HabitData {
  bool isDueToday() {
    if (startDatetime.value.isAfter(DateTime.now())) {
      return false;
    }
    if (repeatOnDaysOfWeek.value != null) {
      int todayIndex = DateTime.now().weekday;
      todayIndex = todayIndex == 7 ? 0 : todayIndex;
      final daysOfWeek = DaysOfWeek.formatForDB(repeatOnDaysOfWeek.value);
      for (int i = 0; i < 7; i++) {
        if (daysOfWeek!.codeUnitAt(i) == 48 /* '1' */ && todayIndex == i) {
          return true;
        }
      }
      return false;
    }
    if (repeatEveryNDays.value != null) {
      if ((DateTime.now().difference(startDatetime.value)).inDays %
              repeatEveryNDays.value! ==
          0) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<CategoryData?> categoryData(Idatabase database) async {
    return database.getCategory(categoryId.value);
  }

  Future<double?> completionState(Idatabase database) async {
    final logs = await database.getLog([id.value]);
    if (logs?[id.value] == null) return 0;
    final logsList = logs![id.value];
    final now = DateTime.now();
    for (final log in logsList!) {
      if (log.datetime.value.day == now.day &&
          log.datetime.value.month == now.month &&
          log.datetime.value.year == now.year) {
        return log.state.value;
      }
    }
    return null;
  }
}
