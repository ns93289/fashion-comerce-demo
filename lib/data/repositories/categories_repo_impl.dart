import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_rep.dart';
import '../dataSources/remote/api_reponse.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../models/model_category.dart';

class CategoriesRepoImpl extends CategoriesRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<CategoryEntity>>> getCategories({required int genderId}) async {
    final response = await _apiHelper.get(
      api: EndPoint.getCategories,
      body: {ApiParams.genderId: genderId, ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)},
    );

    return ResponseWrapper.fromJsonList<ModelCategory>(response, ModelCategory.fromJson);
  }

  @override
  Future<ApiResponse<List<SubCategoryEntity>>> getSubCategories({
    required int categoryId,
    bool isForMale = false,
    bool isForFemale = false,
    bool isForKids = false,
  }) async {
    final response = await _apiHelper.get(
      api: EndPoint.getSubCategories,
      body: {
        ApiParams.categoryId: categoryId,
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
        ApiParams.isForMale: isForMale,
        ApiParams.isForFemale: isForFemale,
        ApiParams.isForKids: isForKids,
      },
    );
    return ResponseWrapper.fromJsonList<ModelSubCategory>(response, ModelSubCategory.fromJson);
  }
}
