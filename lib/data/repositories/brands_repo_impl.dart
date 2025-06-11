import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/brands_entity.dart';
import '../../domain/repositories/brands_repo.dart';
import '../models/brands_model.dart';

class BrandsRepoImpl extends BrandsRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<BrandsEntity>>> getBrands({int page = 1}) async {
    final response = await _apiHelper.get(api: EndPoint.brandsList, body: {ApiParams.page: page});

    return ResponseWrapper.fromJsonList<BrandsEntity>(response, BrandsModel.fromJson);
  }
}
