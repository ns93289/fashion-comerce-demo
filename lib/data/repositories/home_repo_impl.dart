import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/repositories/home_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/home_category_model.dart';
import '../models/search_model.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<HomeCategoryEntity>>> getHomeCategories() async {
    final response = await _apiHelper.get(api: EndPoint.homeCategories, body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});
    return ResponseWrapper.fromJsonList<HomeCategoryEntity>(response, HomeCategoryModel.fromJson);
  }

  @override
  Future<ApiResponse<SearchResultEntity>> searchAll({required String query}) async {
    final response = await _apiHelper.get(api: EndPoint.search,queryParameters: {ApiParams.query: query});

    return ResponseWrapper.fromJson<SearchResultEntity>(response, SearchResultModel.fromJson);
  }
}
