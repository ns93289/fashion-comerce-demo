import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dataSources/remote/api_reponse.dart';
import '../data/models/user_model.dart';
import '../domain/entities/user_entity.dart';
import '../domain/repositories/auth_repo.dart';

class AuthenticationService extends StateNotifier<AsyncValue<UserEntity>> {
  final AuthRepo authRepo;

  AuthenticationService(this.authRepo) : super(AsyncValue.loading());

  Future<void> callSignIn({required String email, required String password}) async {
    if (email.isEmpty) {
      state = const AsyncValue.error("email cannot be empty", StackTrace.empty);
      return;
    } else if (password.isEmpty) {
      state = const AsyncValue.error("email cannot be empty", StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final ApiResponse res = await authRepo.signIn(email: email, password: password);
      if (res is ApiSuccess) {
        state = AsyncValue.data(UserModel.fromJson(res.data));
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
