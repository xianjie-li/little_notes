class DateHelper {
  static String getDateTimeString(DateTime dateTime) {
    var year = dateTime.year.toString();
    var month = dateTime.month.toString().padLeft(2, '0');
    var day = dateTime.day.toString().padLeft(2, '0');
    var hour = dateTime.hour.toString();
    var minute = dateTime.minute.toString().padLeft(2, '0');
    var second = dateTime.second.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute:$second';
  }

  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static int getSinceEpoch() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
