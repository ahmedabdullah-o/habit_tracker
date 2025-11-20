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
}
