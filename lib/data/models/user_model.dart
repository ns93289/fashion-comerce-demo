import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.userId,
    super.fullName,
    super.profilePicture,
    super.email,
    super.mobileNo,
    super.countryCode,
    super.isVerified = false,
    super.accessToken,
    super.mobileVerified = false,
    super.emailVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      fullName: json['full_name'],
      profilePicture: json['profile_picture_url'],
      email: json['email'],
      mobileNo: json['mobile_number'],
      countryCode: json['country_code'],
      isVerified: json['otp_verified'],
      accessToken: json['token'],
      mobileVerified: json['mobile_number_verified'],
      emailVerified: json['email_verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['full_name'] = fullName;
    map['profile_picture_url'] = profilePicture;
    map['email'] = email;
    map['mobile_number'] = mobileNo;
    map['country_code'] = countryCode;
    map['otp_verified'] = isVerified;
    map['mobile_number_verified'] = mobileVerified;
    map['email_verified'] = emailVerified;
    map['token'] = accessToken;
    return map;
  }
}
