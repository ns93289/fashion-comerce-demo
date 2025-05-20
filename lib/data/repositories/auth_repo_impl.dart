import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<UserEntity>> signIn({required String email, required String password}) {
    return _apiHelper.post(api: EndPoint.movieDetails, body: {ApiParams.email: email, ApiParams.password: password});
  }
}
