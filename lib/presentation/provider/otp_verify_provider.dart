import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../main.dart';
import '../../core/utils/tools.dart';
import '../../presentation/components/custom_pin_code_field.dart';

final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});
final authenticationServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<UserEntity?>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});
final otpVerifyProvider = Provider.autoDispose.family<void, ({BuildContext context, bool isPhone})>((ref, args) {
  final otpText = pinCodeKey.currentState?.getPin();
  if (otpText?.length == 6) {
    Future.microtask(() {
      if (args.isPhone) {
        ref.read(authenticationServiceProvider.notifier).callPhoneNumberVerifyApi(otp: otpText ?? "");
      } else {
        ref.read(authenticationServiceProvider.notifier).callEmailVerifyApi(otp: otpText ?? "");
      }
    });
  } else {
    if (args.isPhone) {
      openSimpleSnackBar(language.enterVerificationCodePhone);
    } else {
      openSimpleSnackBar(language.enterVerificationCodeEmail);
    }
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
