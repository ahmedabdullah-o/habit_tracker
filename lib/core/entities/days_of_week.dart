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
  static String? formatForDB(DaysOfWeek? daysOfWeek) {
    if (daysOfWeek == null) {
      return null;
    }
    final buffer = StringBuffer();
    daysOfWeek.sun ? buffer.write('1') : buffer.write('0');
    daysOfWeek.mon ? buffer.write('1') : buffer.write('0');
    daysOfWeek.tue ? buffer.write('1') : buffer.write('0');
    daysOfWeek.wed ? buffer.write('1') : buffer.write('0');
    daysOfWeek.thu ? buffer.write('1') : buffer.write('0');
    daysOfWeek.fri ? buffer.write('1') : buffer.write('0');
    daysOfWeek.sat ? buffer.write('1') : buffer.write('0');
    final out = buffer.toString();
    for (int i = 0; i < 7; i++) {
      if (out[i] == '1') {
        return out;
      }
    }
    return null;
  }

  /// Sets the current instance from a given String, usually formatted like the following: `0101010`. Each bit corresponds to a day of the week from sun to sat.
  static DaysOfWeek? parseFromDB(String? string) {
    bool isUsed = false;
    if (string == null) {
      return null;
    }
    if (string.length != 7) {
      throw Exception('The length of the string should equal 7');
    }
    for (int i = 0; i < 7; i++) {
      if (string[i] == '1') {
        isUsed = true;
      }
      if (string[i] != '0' && string[i] != '1') {
        throw Exception(
          'This string is broken, all bits should equal eihter 0 or 1',
        );
      }
    }
    if (!isUsed) {
      return null;
    }
    DaysOfWeek out = DaysOfWeek();
    string[0] == '1' ? out.sun = true : out.sun = false;
    string[1] == '1' ? out.mon = true : out.mon = false;
    string[2] == '1' ? out.tue = true : out.tue = false;
    string[3] == '1' ? out.wed = true : out.wed = false;
    string[4] == '1' ? out.thu = true : out.thu = false;
    string[5] == '1' ? out.fri = true : out.fri = false;
    string[6] == '1' ? out.sat = true : out.sat = false;
    return out;
  }
}
