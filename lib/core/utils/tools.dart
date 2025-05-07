import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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

logD(String tag, String text) {
  debugPrint("$tag $text");
}

extension CurrencyExtension on dynamic {
  String get withCurrency => "\$$this";
}
