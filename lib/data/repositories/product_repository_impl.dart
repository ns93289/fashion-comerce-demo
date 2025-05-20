import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<ProductEntity>> getNewProductList() {
    return _apiHelper.get(
      api: EndPoint.productList,
      queryParameters: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.accessToken: getStringDataFromUserBox(key: hiveAccessToken)},
    );
  }

  @override
  Future<ApiResponse<ProductEntity>> getPopularProductList() {
    return _apiHelper.get(
      api: EndPoint.popularPproductList,
      queryParameters: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.accessToken: getStringDataFromUserBox(key: hiveAccessToken)},
    );
  }

  @override
  Future<ApiResponse<ProductEntity>> getProductList({int page = 1}) {
    return _apiHelper.get(
      api: EndPoint.newProductList,
      queryParameters: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.accessToken: getStringDataFromUserBox(key: hiveAccessToken),
        ApiParams.page: page,
      },
    );
  }
}
