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
  Future<ApiResponse<List<ProductEntity>>> getNewProductList() {
    // TODO: implement getWalletTransactions
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<ProductEntity>> getPopularProductList() {
    // TODO: implement getWalletTransactions
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<ProductEntity>> getProductList({int page = 1}) {
    // TODO: implement getWalletTransactions
    throw UnimplementedError();
  }

}
