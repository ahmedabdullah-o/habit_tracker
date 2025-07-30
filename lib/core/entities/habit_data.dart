import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/entities/days_of_week.dart';

class HabitData {
  /// this id comes from habits.id. NOT habits_details.id
  ///
  /// Please Don't Manually Modify or Assign
  Value<int> id;

  /// this id comes from habits.current_version
  ///
  /// Please Don't Manually Modify or Assign
  Value<int> currentVersion;
  Value<String> name;
  Value<String> desc;
  Value<int> categoryId;
  Value<DateTime> startDatetime;
  Value<DateTime?> endDatetime;

  /// HH:mm
  Value<TimeOfDay> reminderTime;

  Value<DaysOfWeek?> repeatOnDaysOfWeek;

  /// NOTE: Max value = 7
  Value<int?> repeatEveryNDays;
  Value<String?> targetUnit;
  Value<double?> targetQuantity;
  Value<int?> goalCompletionRate;
  Value<DateTime?> goalDeadline;
  Value<bool> isArchived;

  HabitData({
    this.id = const Value.absent(),
    this.currentVersion = const Value.absent(),
    required this.name,
    required this.desc,
    required this.categoryId,
    required this.startDatetime,
    required this.endDatetime,
    required this.reminderTime,
    this.repeatOnDaysOfWeek = const Value.absent(),
    this.repeatEveryNDays = const Value.absent(),
    this.targetUnit = const Value.absent(),
    this.targetQuantity = const Value.absent(),
    this.goalCompletionRate = const Value(80),
    this.goalDeadline = const Value.absent(),
    this.isArchived = const Value(false),
  });
}
