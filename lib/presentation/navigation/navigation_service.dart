import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(Widget screen) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => screen));
  }

  void navigateToWithReplace(Widget screen) {
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  void navigateToWithClearStack(Widget screen) {
    navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  Future<dynamic>? navigateToWithResult(Widget screen, {List<Override> overrides = const []}) async {
    return await navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => ProviderScope(overrides: overrides, child: screen)));
  }

  Future<dynamic>? showCustomDialog(Widget dialog) async {
    return showDialog(context: navigatorKey.currentContext!, builder: (_) => dialog);
  }

  Future<dynamic>? showBottomSheet(Widget bottomSheet) async {
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => bottomSheet,
    );
  }

  void goBack([Object? result]) {
    navigatorKey.currentState?.pop(result);
  }
}
