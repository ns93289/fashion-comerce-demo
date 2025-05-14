class ModelAddress {
  int? _addressId;
  int? _addressType;
  int? _pinCode;
  String? _houseNo;
  String? _houseNanme;
  String? _street;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;

  ModelAddress({
    int? addressId,
    int? addressType,
    int? pinCode,
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
    _houseNanme = houseName;
    _street = street;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
  }

  ModelAddress.fromJson(Map<String, dynamic> json) {
    _addressId = json['address_id'];
    _addressType = json['address_type'];
    _pinCode = json['pin_code'];
    _houseNo = json['house_no'];
    _houseNanme = json['house_name'];
    _street = json['street'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['address_type'] = _addressType;
    map['pin_code'] = _pinCode;
    map['house_no'] = _houseNo;
    map['house_name'] = _houseNanme;
    map['street'] = _street;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    return map;
  }

  int get addressId => _addressId ?? 0;

  int get addressType => _addressType ?? 0;

  int get pinCode => _pinCode ?? 0;

  String get houseNo => _houseNo ?? "";

  String get houseNanme => _houseNanme ?? "";

  String get street => _street ?? "";

  String get addressLine1 => _addressLine1 ?? "";

  String get addressLine2 => _addressLine2 ?? "";

  String get city => _city ?? "";

  String get state => _state ?? "";

  set addressId(int value) {
    _addressId = value;
  }
}
