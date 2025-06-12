import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
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

logD(String tag, String text) {
  debugPrint("$tag $text");
}
