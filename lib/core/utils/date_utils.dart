// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

class DateAndTimeUtil {

  var DATE_FORMAT = DateFormat('yyyy-MM-dd');
  static var READABLE_DAY_MONTH_YEAR_FORMAT = DateFormat('d MMM, y hh:mm aa');
  static var READABLE_DATE_FORMAT = DateFormat('d MMM, y');
  static var READABLE_TIME_FORMAT = DateFormat('hh:mm aa');

  static var serverDateFormat =
      DateFormat("yyyy-MM-ddTHH:mm:ss.sss"); //YYYY-MM-DDTHH:mm:ss.sssZ
  static var TIME_DAY_MONTH_YEAR_FORMAT = DateFormat('hh:mm aa d MMM, y');

  static String dayMonthYear(String date) {
    return READABLE_DAY_MONTH_YEAR_FORMAT.format(DateTime.parse(date));
  }

  static String readableDate(String date) {
    return READABLE_DATE_FORMAT.format(DateTime.parse(date));
  }

  static String time(String date) {
    return READABLE_TIME_FORMAT.format(DateTime.parse(date));
  }

  static String timeDate(String date) {
    return TIME_DAY_MONTH_YEAR_FORMAT.format(DateTime.parse(date).toLocal());
  }

  static String dayMonthYearFormat(String milliseconds) {

    var now = DateTime.now().toLocal();
    var format = DateFormat('HH:mm a');
    var date = DateTime.parse(
        milliseconds);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} day ago';
      } else {
        time = '${diff.inDays} days ago';
      }
    } else if (diff.inDays >= 7 && diff.inDays < 30) {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} week ago';
      } else {
        time = '${(diff.inDays / 7).floor()} weeks ago';
      }
    } else {
      time = dayMonthYear(milliseconds);
    }
    return time;
  }

  static String currentDateTime() {
    var now =  DateTime.now().toLocal();
    String formattedDate = serverDateFormat.format(now);
    return formattedDate;
  }

  static String expiryDateTime() {
    var now =  DateTime.now().toLocal();
    now = now.add(Duration(days: 1));
    String formattedDate = serverDateFormat.format(now);
    return formattedDate;
  }

  static String getCurrentTimeStamp() {
    return DateTime.now().toLocal().millisecondsSinceEpoch.toString();
  }
}
