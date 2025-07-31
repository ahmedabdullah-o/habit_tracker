import 'dart:ui';

import 'package:drift/drift.dart';

class CategoryData {
  /// PLEASE LEAVE THIS PROPERTY UNTOUCHED IN CASE OF INSERTION
  Value<int> id;
  Value<String> name;
  Value<Color> color;
  Value<int> iconCodePoint;

  CategoryData({
    this.id = const Value.absent(),
    required this.name,
    required this.color,
    required this.iconCodePoint,
  });
}
