class DateHelper {
  static String getDateTimeString(DateTime dateTime) {
    var year = dateTime.year.toString();
    var month = dateTime.month.toString().padLeft(2, '0');
    var day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static bool isSameDay(DateTime d1, DateTime d2) {
    return
      d1.year == d2.year &&
      d1.month == d2.month &&
      d1.day == d2.day;
  }
}
