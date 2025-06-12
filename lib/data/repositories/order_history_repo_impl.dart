import '../../domain/entities/order_history_entity.dart';
import '../../domain/repositories/order_history_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/order_history_model.dart';

class OrderHistoryRepoImpl extends OrderHistoryRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<OrderHistoryEntity>>> getOrderHistoryData({required int page}) async {
    final response = await _apiHelper.get(
      api: EndPoint.orderHistory,
      body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)},
      queryParameters: {ApiParams.page: page},
    );
    return ResponseWrapper.fromJsonList<OrderHistoryEntity>(response, OrderHistoryModel.fromJson);
  }
}
