import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import 'navigation_provider.dart';

final splashActionProvider = FutureProvider.autoDispose.family<void, BuildContext>((ref, context) {
  Future.delayed(Duration(seconds: 3), () {
    if (!context.mounted) return;
    if (getBoolDataFromUserBox(key: hiveEmailVerified) && getBoolDataFromUserBox(key: hivePhoneNumberVerified)) {
      ref.read(navigationServiceProvider).navigateToWithClearStack(HomeScreen());
    } else {
      ref.read(navigationServiceProvider).navigateToWithClearStack(LoginScreen());
    }
  });
});
