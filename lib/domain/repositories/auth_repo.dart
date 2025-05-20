import '../../data/dataSources/remote/api_reponse.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<ApiResponse<UserEntity>> signIn({required String email, required String password});
}
