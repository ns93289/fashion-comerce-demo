import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({super.userId, super.fullName, super.profilePicture, super.email, super.mobileNo, super.countryCode, super.isVerified = false});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      fullName: json['full_name'],
      profilePicture: json['profile_picture'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      countryCode: json['country_code'],
      isVerified: json['is_verified'] == 1 ? true : false,
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['full_name'] = fullName;
    map['profile_picture'] = profilePicture;
    map['email'] = email;
    map['mobile_no'] = mobileNo;
    map['country_code'] = countryCode;
    map['is_verified'] = isVerified;
    return map;
  }
}
