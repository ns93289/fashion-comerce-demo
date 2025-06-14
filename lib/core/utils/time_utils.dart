import 'package:intl/intl.dart';

import '../../main.dart';
import 'tools.dart';

class TimeUtils {
  static String getFormatedDate(String dateTime, {String returnFormat = "EEEE dd MMM yyyy hh:mm aa"}) {
    try {
      return DateFormat(returnFormat, selectedLocale.languageCode).format(DateTime.parse(dateTime));
    } catch (e) {
      logD("getFormatedDate>>>", "${e.toString()} $dateTime");
      return "0000-00-00";
    }
  }

  static DateTime getDateTimeObjFromString(String dateTime) {
    try {
      return DateTime.parse(dateTime);
    } catch (e) {
      logD("getFormatedDate>>>", e.toString());
      return DateTime.now();
    }
  }

  static String formatSecondsToHHmmss(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }
}
