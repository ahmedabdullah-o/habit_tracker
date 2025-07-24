class DaysOfWeek {
  bool sun, mon, tue, wed, thu, fri, sat;
  DaysOfWeek({
    this.sun = false,
    this.mon = false,
    this.tue = false,
    this.wed = false,
    this.thu = false,
    this.fri = false,
    this.sat = false,
  });

  /// Returns days of week formatted for the database.
  String toDBFormat() {
    final buffer = StringBuffer();
    sun ? buffer.write('1') : buffer.write('0');
    mon ? buffer.write('1') : buffer.write('0');
    tue ? buffer.write('1') : buffer.write('0');
    wed ? buffer.write('1') : buffer.write('0');
    thu ? buffer.write('1') : buffer.write('0');
    fri ? buffer.write('1') : buffer.write('0');
    sat ? buffer.write('1') : buffer.write('0');
    return buffer.toString();
  }

  /// Sets the current instance from a given String, usually DB formatted string.
  void fromDBFormat(String format) {
    if (format.length != 7) {
      throw Exception('The length of the string should equal 7');
    }
    for (int i = 0; i < 7; i++) {
      if (format[i] != '0' && format[i] != '1') {
        throw Exception(
          'This format is broken, all bits should equal eihter 0 or 1',
        );
      }
    }
    format[0] == '1' ? sun = true : sun = false;
    format[1] == '1' ? mon = true : mon = false;
    format[2] == '1' ? tue = true : tue = false;
    format[3] == '1' ? wed = true : wed = false;
    format[4] == '1' ? thu = true : thu = false;
    format[5] == '1' ? fri = true : fri = false;
    format[6] == '1' ? sat = true : sat = false;
  }
}
