import '../../domain/entities/address_entity.dart';

class ModelAddress extends AddressEntity {
  ModelAddress({
    super.addressId,
    super.addressLine1,
    super.addressLine2,
    super.addressType,
    super.city,
    super.houseName,
    super.houseNo,
    super.pinCode,
    super.state,
    super.street,
  });

  factory ModelAddress.fromJson(Map<String, dynamic> json) {
    return ModelAddress(
      addressId: json['id'],
      addressType: json['address_type_id'],
      pinCode: json['postal_code'],
      houseNo: json['house_number'],
      houseName: json['house_name'],
      street: json['street'],
      addressLine1: json['line1'],
      addressLine2: json['line2'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = addressId;
    map['address_type_id'] = addressType;
    map['postal_code'] = pinCode;
    map['house_number'] = houseNo;
    map['house_name'] = houseName;
    map['street'] = street;
    map['line1'] = addressLine1;
    map['line2'] = addressLine2;
    map['city'] = city;
    map['state'] = state;
    return map;
  }
}
