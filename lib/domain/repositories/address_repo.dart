import '../entities/address_entity.dart';

abstract class AddressRepo {
  Future<dynamic> addAddress(AddressEntity address);

  Future<dynamic> editAddress(AddressEntity address);

  Future<dynamic> getAddresses();

  Future<dynamic> deleteAddress({required int addressId});
}
