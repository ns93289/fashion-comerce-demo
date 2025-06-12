import '../../domain/entities/order_details_entity.dart';
import '../../domain/repositories/order_details_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/order_details_model.dart';

class OrderDetailsRepoImpl extends OrderDetailsRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<OrderDetailsEntity>> fetchORderDetails({required int orderId}) async {
    final response = await _apiHelper.get(api: "${EndPoint.orderDetails}/$orderId", body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});
    return ResponseWrapper.fromJson<OrderDetailsEntity>(response, OrderDetailsModel.fromJson);
  }
}
