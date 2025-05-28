import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<UserEntity>> signIn({required String email, required String password}) async {
    final response = await _apiHelper.post(api: EndPoint.login, body: {ApiParams.email: email, ApiParams.password: password});

    return ResponseWrapper.fromJson<UserModel>(response, UserModel.fromJson);
  }

  @override
  Future<ApiResponse<UserEntity>> registerUser({required String email, required String password, String? phoneNo, required String name}) async {
    final response = await _apiHelper.post(
      api: EndPoint.register,
      body: {ApiParams.email: email, ApiParams.password: password, ApiParams.name: name, ApiParams.phoneNumber: phoneNo, ApiParams.roleId: 3},
    );

    return ResponseWrapper.fromJson<UserEntity>(response, UserModel.fromJson);
  }

  @override
  Future<ApiResponse<UserEntity>> logout() async {
    final response = await _apiHelper.post(
      api: EndPoint.logout,
      body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.accessToken: getStringDataFromUserBox(key: hiveAccessToken)},
    );
    return ResponseWrapper.fromJson<UserEntity>(response, UserModel.fromJson);
  }

  @override
  Future<ApiResponse<UserEntity>> emailVerify({required String otp}) async {
    final response = await _apiHelper.post(
      api: EndPoint.emailVerification,
      body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.email: getStringDataFromUserBox(key: hiveEmailAddress), ApiParams.code: otp},
    );

    return ResponseWrapper.fromJson<UserModel>(response, UserModel.fromJson);
  }

  @override
  Future<ApiResponse<UserEntity>> phoneNumberVerify({required String otp}) async {
    final response = await _apiHelper.post(
      api: EndPoint.mobileVerification,
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.phoneNumber: getStringDataFromUserBox(key: hivePhoneNumber),
        ApiParams.code: otp,
      },
    );

    return ResponseWrapper.fromJson<UserModel>(response, UserModel.fromJson);
  }

  @override
  Future<ApiResponse<UserEntity>> changePassword({required String password, required String newPassword}) async {
    final response = await _apiHelper.put(
      api: "${EndPoint.changePassword}/${getIntDataFromUserBox(key: hiveUserId)}",
      body: {ApiParams.currentPassword: password, ApiParams.newPassword: newPassword},
    );

    return ResponseWrapper.fromJson<UserModel>(response, UserModel.fromJson);
  }
}
