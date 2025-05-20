class UserEntity {
  int? _userId;
  bool? _isVerified;
  String? _fullName;
  String? _profilePicture;
  String? _email;
  String? _mobileNo;
  String? _countryCode;

  UserEntity({int? userId, String? fullName, String? profilePicture, String? email, String? mobileNo, String? countryCode, bool? isVerified}) {
    _userId = userId;
    _fullName = fullName;
    _profilePicture = profilePicture;
    _email = email;
    _mobileNo = mobileNo;
    _countryCode = countryCode;
    _isVerified = isVerified;
  }

  int get userId => _userId ?? 0;

  String get fullName => _fullName ?? '';

  String get profilePicture => _profilePicture ?? '';

  String get email => _email ?? '';

  String get mobileNo => _mobileNo ?? '';

  String get countryCode => _countryCode ?? '';

  bool get isVerified => _isVerified ?? false;
}
