import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/base_model.dart';
import '../models/model_address.dart';

class AddressRepoImpl extends AddressRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<ModelAddress>> addAddress(AddressEntity address) async {
    final response = await _apiHelper.post(
      api: EndPoint.addAddress,
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.addressTypeId: address.addressType,
        ApiParams.houseName: address.houseName,
        ApiParams.houseNumber: address.houseNo,
        ApiParams.street: address.street,
        ApiParams.line1: address.addressLine1,
        ApiParams.line2: address.addressLine2,
        ApiParams.city: address.city,
        ApiParams.state: address.state,
        ApiParams.postalCode: address.pinCode,
        ApiParams.country: null,
      },
    );

    return ResponseWrapper.fromJson<ModelAddress>(response, ModelAddress.fromJson);
  }

  @override
  Future<ApiResponse<BaseModel>> deleteAddress({required int addressId}) async {
    final response = await _apiHelper.delete(api: "${EndPoint.deleteAddress}/$addressId", body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});

    return ResponseWrapper.fromJson<BaseModel>(response, BaseModel.fromJson);
  }

  @override
  Future editAddress(AddressEntity address) async {
    final response = await _apiHelper.put(
      api: "${EndPoint.editAddress}/${address.addressId}",
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.addressTypeId: address.addressType,
        ApiParams.houseName: address.houseName,
        ApiParams.houseNumber: address.houseNo,
        ApiParams.street: address.street,
        ApiParams.line1: address.addressLine1,
        ApiParams.line2: address.addressLine2,
        ApiParams.city: address.city,
        ApiParams.state: address.state,
        ApiParams.postalCode: address.pinCode,
        ApiParams.country: null,
      },
    );

    return ResponseWrapper.fromJson<ModelAddress>(response, ModelAddress.fromJson);
  }

  @override
  Future<ApiResponse<List<AddressEntity>>> getAddresses() async {
    final response = await _apiHelper.get(api: EndPoint.getAddress, body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});

    return ResponseWrapper.fromJsonList<AddressEntity>(response, ModelAddress.fromJson);
  }
}
