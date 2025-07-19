enum HabitsLogState {
  // DON'T REORDER VALUES,
  // APPEND ONLY!
  // These enums are defined as intEnum in our drift db Table definition which
  // depends on the order of the enums values.
  done,
  fail,
  skip,
  none,
}

enum CategoriesColor {
  // DON'T REORDER VALUES,
  // APPEND ONLY!
  // These enums are defined as intEnum in our drift db Table definition which
  // depends on the order of the enums values.
  // TODO: define colors and enhanced enum.
  blue,
  green,
  grey,
}

enum CategoriesIcon {
  // DON'T REORDER VALUES,
  // APPEND ONLY!
  // These enums are defined as intEnum in our drift db Table definition which
  // depends on the order of the enums values.
  // TODO: define Icon names and design. Maybe even make it an enhanced enum
  icon1,
  icon2,
  icon3,
}
