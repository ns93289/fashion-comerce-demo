import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/repositories/auth_repo.dart';

final passwordTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final newPasswordTECProvider = Provider.autoDispose<TextEditingController>((ref) {
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
final changePasswordProvider = Provider.autoDispose<void>((ref) {
  final passwordTEC = ref.watch(passwordTECProvider);
  final newPasswordTEC = ref.watch(passwordTECProvider);

  Future.microtask(() {
    ref.read(authenticationServiceProvider.notifier).callChangePasswordApi(password: passwordTEC.text, newPassword: newPasswordTEC.text);
  });
});

final changePasswordFormKey = GlobalKey<FormState>();
