import 'package:dio/dio.dart';

abstract class UserProfileRepo {
  Future<dynamic> updateProfile({required String email, required String phoneNumber, required String name, MultipartFile? profilePicture});
}
