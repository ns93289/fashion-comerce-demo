import '../../data/dataSources/remote/api_reponse.dart';
import '../entities/brands_entity.dart';

abstract class BrandsRepo {
  Future<dynamic> getBrands({int page = 1});
}
