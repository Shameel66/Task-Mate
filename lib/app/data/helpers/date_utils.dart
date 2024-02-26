import 'package:intl/intl.dart';

class DateUtilsClass {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('d MMM').format(dateTime);
  }

  static String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time); // Formats time as 10:00 AM
  }
}