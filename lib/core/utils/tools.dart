import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../constants/colors.dart';

TextStyle bodyTextStyle({Color? color, double? fontSize, FontWeight? fontWeight}) {
  return GoogleFonts.roboto(color: color ?? colorText, fontSize: fontSize ?? 16.sp, fontWeight: fontWeight ?? FontWeight.normal, height: 0);
}

openScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

openScreenWithClearStack(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
}

openSimpleSnackBar(String message) {
  SnackBar snackBar = SnackBar(content: Text(message, style: bodyTextStyle(color: colorWhite)));
  scaffoldKey.currentState?.showSnackBar(snackBar);
}

String getFormatedDate(String dateTime, {String format = "yyyy-MM-dd HH:mm:ss", String returnFormat = "EEE dd MMM yyyy hh:mm aa"}) {
  try {
    return DateFormat(returnFormat).format(DateFormat(format).parse(dateTime));
  } catch (e) {
    logD("getFormatedDate>>>", e.toString());
    return "0000-00-00";
  }
}

DateTime getDateTimeObjFromString(String dateTime, {String format = "yyyy-MM-dd HH:mm:ss"}) {
  try {
    return DateTime.parse(DateFormat(format).parse(dateTime).toString());
  } catch (e) {
    logD("getFormatedDate>>>", e.toString());
    return DateTime.now();
  }
}

logD(String tag, String text) {
  debugPrint("$tag $text");
}

extension CurrencyExtension on dynamic {
  String get withCurrency => "\$$this";
}
