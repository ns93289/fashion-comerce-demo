import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle bodyTextStyle({Color? color, double? fontSize, FontWeight? fontWeight, TextDecoration? decoration}) {
  return GoogleFonts.raleway(
    color: color ?? colorText,
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight ?? FontWeight.normal,
    height: 1,
    decoration: decoration,
  );
}
