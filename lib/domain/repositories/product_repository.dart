import '../../data/dataSources/remote/api_reponse.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<ApiResponse<ProductEntity>> getProductList({int page = 1});

  Future<ApiResponse<ProductEntity>> getNewProductList();

  Future<ApiResponse<ProductEntity>> getPopularProductList();
}
