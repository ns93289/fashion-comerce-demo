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
}
