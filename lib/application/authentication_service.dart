import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/local/hive_constants.dart';
import '../data/dataSources/local/hive_helper.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/user_entity.dart';
import '../domain/repositories/auth_repo.dart';

class AuthenticationService extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepo authRepo;

  AuthenticationService(this.authRepo) : super(AsyncValue.data(null));

  Future<void> callSignInApi({required String email, required String password}) async {
    if (email.isEmpty) {
      state = const AsyncValue.error("email cannot be empty", StackTrace.empty);
      return;
    } else if (password.isEmpty) {
      state = const AsyncValue.error("email cannot be empty", StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final res = await authRepo.signIn(email: email, password: password);
      if (res is ApiSuccess) {
        final UserEntity user = res.data;
        putDataInUserBox(key: hiveUserId, value: user.userId);
        putDataInUserBox(key: hivePhoneNumber, value: user.mobileNo);
        putDataInUserBox(key: hiveFullName, value: user.fullName);
        putDataInUserBox(key: hiveEmailAddress, value: user.email);
        putDataInUserBox(key: hiveProfilePicture, value: user.profilePicture);
        putDataInUserBox(key: hiveAccessToken, value: user.accessToken);
        putDataInUserBox(key: hiveUserIsVerified, value: user.isVerified);
        putDataInUserBox(key: hivePhoneNumberVerified, value: user.mobileVerified);
        putDataInUserBox(key: hiveEmailVerified, value: user.emailVerified);
        state = AsyncValue.data(user);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callSignIn>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callEmailVerifyApi({required String otp}) async {
    state = const AsyncValue.loading();

    try {
      final res = await authRepo.emailVerify(otp: otp);
      if (res is ApiSuccess) {
        putDataInUserBox(key: hiveEmailVerified, value: true);
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callEmailVerifyApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callPhoneNumberVerifyApi({required String otp}) async {
    state = const AsyncValue.loading();

    try {
      final res = await authRepo.phoneNumberVerify(otp: otp);
      if (res is ApiSuccess) {
        putDataInUserBox(key: hivePhoneNumberVerified, value: true);
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callPhoneNumberVerifyApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callRegisterApi({required String email, required String password, required String phoneNo, required String name}) async {
    if (email.isEmpty) {
      state = const AsyncValue.error("email cannot be empty", StackTrace.empty);
      return;
    } else if (password.isEmpty) {
      state = const AsyncValue.error("password cannot be empty", StackTrace.empty);
      return;
    } else if (name.isEmpty) {
      state = const AsyncValue.error("name cannot be empty", StackTrace.empty);
      return;
    } else if (phoneNo.isEmpty) {
      state = const AsyncValue.error("name cannot be empty", StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final res = await authRepo.registerUser(email: email, password: password, name: name, phoneNo: phoneNo);
      if (res is ApiSuccess) {
        final UserEntity user = res.data;
        putDataInUserBox(key: hiveUserId, value: user.userId);
        putDataInUserBox(key: hivePhoneNumber, value: user.mobileNo);
        putDataInUserBox(key: hiveFullName, value: user.fullName);
        putDataInUserBox(key: hiveEmailAddress, value: user.email);
        putDataInUserBox(key: hiveProfilePicture, value: user.profilePicture);
        putDataInUserBox(key: hiveAccessToken, value: user.accessToken);
        putDataInUserBox(key: hiveUserIsVerified, value: user.isVerified);
        putDataInUserBox(key: hivePhoneNumberVerified, value: user.mobileVerified);
        putDataInUserBox(key: hiveEmailVerified, value: user.emailVerified);
        state = AsyncValue.data(user);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callRegisterApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callChangePasswordApi({required String password, required String newPassword}) async {
    if (password.isEmpty) {
      state = const AsyncValue.error("password cannot be empty", StackTrace.empty);
      return;
    } else if (newPassword.isEmpty) {
      state = const AsyncValue.error("new password cannot be empty", StackTrace.empty);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final res = await authRepo.changePassword(password: password, newPassword: newPassword);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callChangePasswordApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callForgotPasswordApi({required String email}) async {
    if (email.isEmpty) {
      state = const AsyncValue.error("email cannot be empty", StackTrace.empty);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final res = await authRepo.forgotPassword(email: email);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callForgotPasswordApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callForgotChangePasswordApi({required String otp, required String password}) async {
    if (otp.isEmpty) {
      state = const AsyncValue.error("otp cannot be empty", StackTrace.empty);
      return;
    } else if (password.isEmpty) {
      state = const AsyncValue.error("password cannot be empty", StackTrace.empty);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final res = await authRepo.forgotChangePassword(otp: otp, password: password);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callForgotChangePasswordApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callLogoutApi() async {
    state = const AsyncValue.loading();

    try {
      final res = await authRepo.logout();
      if (res is ApiSuccess) {
        clearAllBoxes().then((value) {
          state = AsyncValue.data(res.data);
        });
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callLogoutApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }
}
