import 'package:country_code_picker/country_code_picker.dart';
import 'package:fashion_comerce_demo/core/utils/tools.dart';
import 'package:fashion_comerce_demo/data/dataSources/local/hive_constants.dart';
import 'package:fashion_comerce_demo/data/dataSources/local/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/screens/otp/otp_screen.dart';

final fullNameTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final phoneNoTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final emailTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final countryCodeTECProvider = StateProvider<CountryCode>((ref) {
  return CountryCode(name: "US", dialCode: "+1", code: "US");
});
final passwordTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final confirmPasswordTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final registrationProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final countryCode = ref.watch(countryCodeTECProvider);
  final phoneNoTEC = ref.watch(phoneNoTECProvider);
  final fullNameTEC = ref.watch(fullNameTECProvider);
  final emailTEC = ref.watch(emailTECProvider);
  final passwordTEC = ref.watch(passwordTECProvider);
  putDataInUserBox(key: hiveCountryCode, value: countryCode.dialCode);
  putDataInUserBox(key: hivePhoneNumber, value: phoneNoTEC.text);
  putDataInUserBox(key: hiveFullName, value: fullNameTEC.text);
  putDataInUserBox(key: hiveEmailAddress, value: emailTEC.text);
  putDataInUserBox(key: hiveUserPassword, value: passwordTEC.text);

  openScreenWithReplace(context, OtpScreen());
});

final signupFormKey = GlobalKey<FormState>();
