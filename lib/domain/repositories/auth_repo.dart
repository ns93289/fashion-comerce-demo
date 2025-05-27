abstract class AuthRepo {
  Future<dynamic> signIn({required String email, required String password});

  Future<dynamic> emailVerify({required String otp});

  Future<dynamic> phoneNumberVerify({required String otp});

  Future<dynamic> registerUser({required String email, required String password, required String phoneNo, required String name});

  Future<dynamic> logout();
}
