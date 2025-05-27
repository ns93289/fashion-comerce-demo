import 'package:dio/dio.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_profile_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/user_model.dart';

class UserProfileRepoImpl extends UserProfileRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<UserEntity>> updateProfile({
    required String email,
    required String phoneNumber,
    required String name,
    MultipartFile? profilePicture,
  }) async {
    final response = await _apiHelper.putForm(
      api: "${EndPoint.updateProfile}/${getIntDataFromUserBox(key: hiveUserId)}",
      body: FormData.fromMap({
        ApiParams.email: email,
        ApiParams.profilePicture: profilePicture,
        ApiParams.name: name,
        ApiParams.phoneNumber: phoneNumber,
        ApiParams.roleId: 3,
      }),
    );

    return ResponseWrapper.fromJson<UserEntity>(response, UserModel.fromJson);
  }
}
