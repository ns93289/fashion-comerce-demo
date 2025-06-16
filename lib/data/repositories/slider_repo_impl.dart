import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/slider_repo.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../models/slider_model.dart';

class SliderRepoImpl extends SliderRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<SliderEntity>>> getSliderData({bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    final response = await _apiHelper.get(
      api: EndPoint.homeSlider,
      body: {ApiParams.isForMale: isForMale, ApiParams.isForFemale: isForFemale, ApiParams.isForKids: isForKids},
    );

    return ResponseWrapper.fromJsonList<SliderEntity>(response, SliderModel.fromJson);
  }
}
