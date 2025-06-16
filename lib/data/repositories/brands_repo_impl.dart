import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/brands_entity.dart';
import '../../domain/repositories/brands_repo.dart';
import '../models/brands_model.dart';

class BrandsRepoImpl extends BrandsRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<BrandsEntity>>> getBrands({bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    final response = await _apiHelper.get(
      api: EndPoint.brandsList,
      body: {
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.isForMale: isForMale,
        ApiParams.isForFemale: isForFemale,
        ApiParams.isForKids: isForKids,
      },
    );

    return ResponseWrapper.fromJsonList<BrandsEntity>(response, BrandsModel.fromJson);
  }
}
