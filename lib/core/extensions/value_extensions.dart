import 'package:drift/drift.dart';

extension ValueExtensions on Value {
  /// same as variable.value but returns null if the variable equals Value.absent.
  dynamic get safeValue {
    if (this == Value.absent()) {
      return null;
    }
    return value;
  }
}
