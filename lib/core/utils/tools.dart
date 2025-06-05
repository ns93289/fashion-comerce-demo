import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../constants/app_constants.dart';
import '../constants/colors.dart';
import '../constants/theme.dart';

openScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

openScreenWithReplace(BuildContext context, Widget screen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
}

Future<dynamic> openScreenWithResult(BuildContext context, Widget screen, {List<Override> overrides = const []}) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderScope(overrides: overrides, child: screen)));
}

openScreenWithClearStack(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
}

openSimpleSnackBar(String message) {
  SnackBar snackBar = SnackBar(content: Text(message, style: bodyTextStyle(color: colorWhite)));
  scaffoldKey.currentState?.showSnackBar(snackBar);
}

String getFormatedDate(String dateTime, {String format = "yyyy-MM-dd HH:mm:ss", String returnFormat = "EEEE dd MMM yyyy hh:mm aa"}) {
  try {
    return DateFormat(returnFormat, selectedLocale.languageCode).format(DateFormat(format).parse(dateTime));
  } catch (e) {
    logD("getFormatedDate>>>", "${e.toString()} $dateTime");
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

IconData getAddressIcon(int addressType) {
  if (addressType == AddressTypes.home) {
    return Icons.home_outlined;
  } else if (addressType == AddressTypes.work) {
    return Icons.work_outline;
  } else {
    return Icons.location_on_outlined;
  }
}

String getAddressTitle(int addressType) {
  if (addressType == AddressTypes.home) {
    return language.home;
  } else if (addressType == AddressTypes.work) {
    return language.work;
  } else if (addressType == AddressTypes.family) {
    return language.familyOrFriend;
  } else {
    return language.other;
  }
}

logD(String tag, String text) {
  debugPrint("$tag $text");
}
