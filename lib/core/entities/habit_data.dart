import 'package:flutter/material.dart';
import 'package:habit_tracker/core/entities/days_of_week.dart';

class HabitData {
  int? id;
  String name;
  String desc;
  int categoryId;
  DateTime startDatetime;
  DateTime endDatetime;

  /// HH:mm
  TimeOfDay reminderTime;

  DaysOfWeek? repeatOnDaysOfWeek;

  /// NOTE: Max value = 7
  int? repeatEveryNDays;
  String? targetUnit;
  double? targetQuantity;
  int? goalCompletionRate = 80;
  DateTime? goalDeadline;
  bool isArchived = false;

  HabitData({
    this.id,
    required this.name,
    required this.desc,
    required this.categoryId,
    required this.startDatetime,
    required this.endDatetime,
    required this.reminderTime,
    this.repeatOnDaysOfWeek,
    this.repeatEveryNDays,
    this.targetUnit,
    this.targetQuantity,
    this.goalCompletionRate = 80,
    this.goalDeadline,
    this.isArchived = false,
  });
}
