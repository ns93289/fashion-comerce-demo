import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../main.dart';
import '../../core/utils/tools.dart';
import '../../presentation/components/custom_pin_code_field.dart';
import '../../presentation/screens/home/home_screen.dart';

final otpVerifyProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final otpText = pinCodeKey.currentState?.getPin();
  logD("otpVerifyProvider>>>", otpText?.length.toString() ?? "");
  if (otpText?.length == 6) {
    putDataInUserBox(key: hiveUserIsVerified);
    openScreenWithClearStack(context, HomeScreen());
  } else {
    openSimpleSnackBar(language.enterVerificationCode);
  }
});

final resendDurationProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final resendOTPProvider = Provider.autoDispose((ref) {
  int remainingSeconds = 60;
  Timer.periodic(const Duration(seconds: 1), (timer) {
    if (remainingSeconds > 0) {
      remainingSeconds--;
      ref.read(resendDurationProvider.notifier).state = remainingSeconds;
    } else {
      timer.cancel();
    }
  });
});

final GlobalKey<CustomPinCodeFieldState> pinCodeKey = GlobalKey();
