import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../main.dart';
import '../../core/utils/tools.dart';
import '../../presentation/screens/home/home_screen.dart';

final otpTextProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

final otpVerifyProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final otpText = ref.watch(otpTextProvider);
  if (otpText.length == 6) {
    putDataInUserBox(key: hiveUserIsVerified);
    openScreen(context, HomeScreen());
  } else {
    openSimpleSnackBar(language.enterVerificationCode);
  }
});
