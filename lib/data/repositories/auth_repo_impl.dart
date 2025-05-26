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
      api: EndPoint.register,
      body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.accessToken: getStringDataFromUserBox(key: hiveAccessToken)},
    );
    return ResponseWrapper.fromJson<UserEntity>(response, UserModel.fromJson);
  }
}
