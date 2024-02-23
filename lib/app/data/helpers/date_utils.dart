import 'package:intl/intl.dart';

class DateUtilsClass {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('d MMM').format(dateTime);
  }
}