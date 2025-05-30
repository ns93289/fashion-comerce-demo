import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../dialogs/forgot_password_dialog.dart';

final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});
final authServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<UserEntity?>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});
final forgotPasswordProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  showDialog(
    context: context,
    builder: (context) {
      return ForgotPasswordDialog();
    },
  );
});
