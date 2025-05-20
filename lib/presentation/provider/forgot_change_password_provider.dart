import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/tools.dart';
import '../../presentation/dialogs/forgot_change_password_dialog.dart';
import '../../presentation/screens/home/home_screen.dart';

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
final otpTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final changePasswordProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  showDialog(
    context: context,
    builder: (context) {
      return ForgotChangePasswordDialog(
        title: language.change,
        onPositiveClick: () {
          if (changePasswordFormKey.currentState!.validate()) {
            Navigator.pop(context);
            openScreenWithClearStack(context, HomeScreen());
          }
        },
        onNegativeClick: () => Navigator.pop(context),
      );
    },
  );
});

final changePasswordFormKey = GlobalKey<FormState>();
