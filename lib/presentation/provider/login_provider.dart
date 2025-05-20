import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../core/utils/tools.dart';
import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/otp/otp_screen.dart';

final phoneNoTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final passwordTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final countryCodeTECProvider = StateProvider<CountryCode>((ref) {
  return CountryCode(name: "US", dialCode: "+1", code: "US");
});

final loginCheckProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final countryCode = ref.watch(countryCodeTECProvider);
  final phoneNoTEC = ref.watch(phoneNoTECProvider);
  if (getStringDataFromUserBox(key: hivePhoneNumber) == phoneNoTEC.text && getStringDataFromUserBox(key: hiveCountryCode) == countryCode.dialCode) {
    final passwordTEC = ref.watch(passwordTECProvider);
    if (getStringDataFromUserBox(key: hiveUserPassword) == passwordTEC.text) {
      if (getBoolDataFromUserBox(key: hiveUserIsVerified)) {
        openScreenWithClearStack(context, HomeScreen());
      } else {
        openScreen(context, OtpScreen());
      }
    } else {
      openSimpleSnackBar("Invalid Credentials");
    }
  } else {
    openSimpleSnackBar("App user not found");
  }
});

final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});

final authenticationServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<UserEntity>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});

final loginProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final countryCode = ref.watch(countryCodeTECProvider);
  final phoneNoTEC = ref.watch(phoneNoTECProvider);
  final passwordTEC = ref.watch(passwordTECProvider);

  ref.read(authenticationServiceProvider.notifier).callSignIn(email: "${countryCode.dialCode}${phoneNoTEC.text}", password: passwordTEC.text);

  final apiResponse = ref.watch(authenticationServiceProvider);
  apiResponse.whenOrNull(
    data: (data) {
      putDataInUserBox(key: hiveUserId, value: data.userId);
      putDataInUserBox(key: hivePhoneNumber, value: data.mobileNo);
      putDataInUserBox(key: hiveCountryCode, value: data.countryCode);
      putDataInUserBox(key: hiveEmailAddress, value: data.email);
      putDataInUserBox(key: hiveFullName, value: data.fullName);
      putDataInUserBox(key: hiveProfilePicture, value: data.profilePicture);
      putDataInUserBox(key: hiveUserIsVerified, value: data.isVerified);
      if (data.isVerified) {
        openScreenWithClearStack(context, HomeScreen());
      } else {
        openScreen(context, OtpScreen());
      }
    },
  );
});

final loginFormKey = GlobalKey<FormState>();
