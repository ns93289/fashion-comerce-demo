import '../../core/constants/app_constants.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/model_product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<ProductEntity>>> getNewProductList() async {
    final response = await _apiHelper.get(api: EndPoint.newProductList, body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }

  @override
  Future<ApiResponse<List<ProductEntity>>> getPopularProductList() async {
    final response = await _apiHelper.get(api: EndPoint.popularProductList, body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }

  @override
  Future<ApiResponse<List<ProductEntity>>> getProductList({int page = 1}) async {
    final response = await _apiHelper.get(
      api: EndPoint.productList,
      queryParameters: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.page: page, ApiParams.size: DefaultData.pageSize},
    );

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }
}
