import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/local/hive_constants.dart';
import '../data/dataSources/local/hive_helper.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/user_entity.dart';
import '../domain/repositories/user_profile_repo.dart';

class UserProfileService extends StateNotifier<AsyncValue<UserEntity?>> {
  final UserProfileRepo userProfileRepo;

  UserProfileService(this.userProfileRepo) : super(AsyncData(null));

  Future<void> callUpdateProfileApi({required String email, required String phoneNumber, required String name, String? filePath}) async {
    MultipartFile? profilePicture;
    if (filePath != null) {
      profilePicture = MultipartFile.fromFileSync(filePath, filename: filePath.split('/').last);
    }
    state = const AsyncValue.loading();
    try {
      final res = await userProfileRepo.updateProfile(email: email, phoneNumber: phoneNumber, name: name, profilePicture: profilePicture);
      if (res is ApiSuccess) {
        final UserEntity user = res.data;
        putDataInUserBox(key: hivePhoneNumber, value: user.mobileNo);
        putDataInUserBox(key: hiveFullName, value: user.fullName);
        putDataInUserBox(key: hiveEmailAddress, value: user.email);
        putDataInUserBox(key: hiveProfilePicture, value: user.profilePicture);
        state = AsyncValue.data(user);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callUpdateProfileApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, st);
    }
  }
}
