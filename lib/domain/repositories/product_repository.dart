import '../../data/dataSources/remote/api_reponse.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<dynamic> getProductList({int page = 1});

  Future<dynamic> getNewProductList();

  Future<dynamic> getPopularProductList();
}
