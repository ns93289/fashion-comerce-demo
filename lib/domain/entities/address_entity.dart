class AddressEntity {
  int? _addressId;
  int? _addressType;
  String? _pinCode;
  String? _houseNo;
  String? _houseName;
  String? _street;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;

  AddressEntity({
    int? addressId,
    int? addressType,
    String? pinCode,
    String? houseNo,
    String? houseName,
    String? street,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
  }) {
    _addressId = addressId;
    _addressType = addressType;
    _pinCode = pinCode;
    _houseNo = houseNo;
    _houseName = houseName;
    _street = street;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
  }

  int get addressId => _addressId ?? 0;

  int get addressType => _addressType ?? 0;

  String get pinCode => _pinCode ?? "";

  String get houseNo => _houseNo ?? "";

  String get houseName => _houseName ?? "";

  String get street => _street ?? "";

  String get addressLine1 => _addressLine1 ?? "";

  String get addressLine2 => _addressLine2 ?? "";

  String get city => _city ?? "";

  String get state => _state ?? "";
}
