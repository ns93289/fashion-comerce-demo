import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/colors.dart';
import '../constants/theme.dart';

openSimpleSnackBar(String message) {
  SnackBar snackBar = SnackBar(content: Text(message, style: bodyTextStyle(color: colorWhite)));
  scaffoldKey.currentState?.showSnackBar(snackBar);
}

logD(String tag, String text) {
  debugPrint("$tag $text");
}
