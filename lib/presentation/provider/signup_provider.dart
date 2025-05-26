import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';

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
final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});
final authenticationServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<dynamic>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});
final signUpProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final phoneNoTEC = ref.watch(phoneNoTECProvider);
  final passwordTEC = ref.watch(passwordTECProvider);
  final fullNameTEC = ref.watch(fullNameTECProvider);
  final emailTEC = ref.watch(emailTECProvider);

  Future.microtask(() {
    ref
        .read(authenticationServiceProvider.notifier)
        .callRegisterApi(email: emailTEC.text, password: passwordTEC.text, name: fullNameTEC.text, phoneNo: phoneNoTEC.text);
  });
});

final signupFormKey = GlobalKey<FormState>();
