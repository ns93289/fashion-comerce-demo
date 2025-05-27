import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../core/utils/tools.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/login/login_screen.dart';

final splashActionProvider = FutureProvider.autoDispose.family<void, BuildContext>((ref, context) {
  Future.delayed(Duration(seconds: 3), () {
    if (!context.mounted) return;
    if (getBoolDataFromUserBox(key: hiveEmailVerified) && getBoolDataFromUserBox(key: hivePhoneNumberVerified)) {
      openScreenWithClearStack(context, HomeScreen());
    } else {
      openScreenWithClearStack(context, LoginScreen());
    }
  });
});
