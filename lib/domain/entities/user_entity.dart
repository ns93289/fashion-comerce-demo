class UserEntity {
  int? _userId;
  bool? _isVerified;
  bool? _mobileVerified;
  bool? _emailVerified;
  String? _fullName;
  String? _profilePicture;
  String? _email;
  String? _mobileNo;
  String? _countryCode;
  String? _accessToken;

  UserEntity({
    int? userId,
    String? fullName,
    String? profilePicture,
    String? email,
    String? mobileNo,
    String? countryCode,
    String? accessToken,
    bool? isVerified,
    bool? mobileVerified,
    bool? emailVerified,
  }) {
    _userId = userId;
    _fullName = fullName;
    _profilePicture = profilePicture;
    _email = email;
    _mobileNo = mobileNo;
    _countryCode = countryCode;
    _accessToken = accessToken;
    _isVerified = isVerified;
    _mobileVerified = mobileVerified;
    _emailVerified = emailVerified;
  }

  int get userId => _userId ?? 0;

  String get fullName => _fullName ?? '';

  String get profilePicture => _profilePicture ?? '';

  String get email => _email ?? '';

  String get mobileNo => _mobileNo ?? '';

  String get countryCode => _countryCode ?? '';

  String get accessToken => _accessToken ?? '';

  bool get isVerified => _isVerified ?? false;

  bool get mobileVerified => _mobileVerified ?? false;

  bool get emailVerified => _emailVerified ?? false;
}
