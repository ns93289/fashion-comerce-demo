import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/tools.dart';
import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
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

final loginFormKey = GlobalKey<FormState>();
