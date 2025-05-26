import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';

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

final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});

final authenticationServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<UserEntity?>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});

final loginProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final phoneNoTEC = ref.watch(phoneNoTECProvider);
  final passwordTEC = ref.watch(passwordTECProvider);

  Future.microtask(() {
    ref.read(authenticationServiceProvider.notifier).callSignInApi(email: phoneNoTEC.text, password: passwordTEC.text);
  });
});

final loginFormKey = GlobalKey<FormState>();
