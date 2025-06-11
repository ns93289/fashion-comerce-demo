import '../../domain/repositories/place_order_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/base_model.dart';

class PlaceOrderRepoImpl extends PlaceOrderRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<BaseModel>> placeOrder({required int paymentType, required int addressId}) async {
    final response = await _apiHelper.post(
      api: EndPoint.placeOrder,
      body: {ApiParams.paymentMethod: paymentType, ApiParams.addressId: addressId, ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)},
    );

    return ResponseWrapper.fromJson<BaseModel>(response, BaseModel.fromJson);
  }
}
