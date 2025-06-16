import '../../domain/entities/product_details_entity.dart';
import '../../domain/repositories/product_details_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/product_details_model.dart';

class ProductDetailsRepoImpl extends ProductDetailsRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<ProductDetailsEntity>> getProductDetails({required int id, String? size, String? color}) async {
    final response = await _apiHelper.get(
      api: "${EndPoint.productDetails}/$id",
      body: {ApiParams.size: size, ApiParams.color: color},
      queryParameters: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)},
    );
    return ResponseWrapper.fromJson<ProductDetailsEntity>(response, ProductDetailsModel.fromJson);
  }
}
