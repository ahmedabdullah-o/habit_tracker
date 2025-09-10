import 'package:drift/drift.dart';

class LogData {
  Value<int> habitId;
  Value<int> habitDetailsVersion;
  Value<double?> state;
  Value<DateTime> datetime;
  LogData({
    required this.habitId,
    required this.habitDetailsVersion,
    required this.state,
    this.datetime = const Value.absent(),
  });
}
