import '../../core/constants/app_constants.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/base_model.dart';
import '../models/model_product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<ProductEntity>>> getNewProductList({
    int page = 1,
    bool isForMale = false,
    bool isForFemale = false,
    bool isForKids = false,
    int categoryId = 0,
    int brandId = 0,
  }) async {
    final response = await _apiHelper.get(
      api: EndPoint.newProductList,
      queryParameters: {ApiParams.page: page, ApiParams.size: DefaultData.pageSize},
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.isForMale: isForMale,
        ApiParams.isForFemale: isForFemale,
        ApiParams.isForKids: isForKids,
        ApiParams.subCategoryId: categoryId,
        ApiParams.brandId: brandId,
      },
    );

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }

  @override
  Future<ApiResponse<List<ProductEntity>>> getPopularProductList({
    int page = 1,
    bool isForMale = false,
    bool isForFemale = false,
    bool isForKids = false,
    int categoryId = 0,
    int brandId = 0,
  }) async {
    final response = await _apiHelper.get(
      api: EndPoint.popularProductList,
      queryParameters: {ApiParams.page: page, ApiParams.size: DefaultData.pageSize},
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.isForMale: isForMale,
        ApiParams.isForFemale: isForFemale,
        ApiParams.isForKids: isForKids,
        ApiParams.subCategoryId: categoryId,
        ApiParams.brandId: brandId,
      },
    );

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }

  @override
  Future<ApiResponse<List<ProductEntity>>> getProductList({
    int page = 1,
    bool isForMale = false,
    bool isForFemale = false,
    bool isForKids = false,
    int categoryId = 0,
    int brandId = 0,
  }) async {
    final response = await _apiHelper.get(
      api: EndPoint.productList,
      queryParameters: {ApiParams.page: page, ApiParams.size: DefaultData.pageSize},
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.isForMale: isForMale,
        ApiParams.isForFemale: isForFemale,
        ApiParams.isForKids: isForKids,
        ApiParams.subCategoryId: categoryId,
        ApiParams.brandId: brandId,
      },
    );

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }

  @override
  Future<ApiResponse<BaseModel>> favoriteProduct({required int productId, required int favorite}) async {
    final response = await _apiHelper.post(
      api: EndPoint.addFavourite,
      body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.type: favorite, ApiParams.productId: productId},
    );
    return ResponseWrapper.fromJson<BaseModel>(response, BaseModel.fromJson);
  }

  @override
  Future<ApiResponse<List<ProductEntity>>> getFavoriteProductList() async {
    final response = await _apiHelper.get(api: "${EndPoint.getFavouriteProducts}/${getIntDataFromUserBox(key: hiveUserId)}");

    return ResponseWrapper.fromJsonList<ProductEntity>(response, ModelProduct.fromJson);
  }
}
