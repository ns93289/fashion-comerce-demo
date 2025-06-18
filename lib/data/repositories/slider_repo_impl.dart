import '../dataSources/remote/api_reponse.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/slider_repo.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../models/slider_model.dart';

class SliderRepoImpl extends SliderRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<List<SliderEntity>>> getSliderData({int action = 0, int type = 0}) async {
    final response = await _apiHelper.get(api: EndPoint.homeSlider, body: {ApiParams.action: action, ApiParams.type: type});

    return ResponseWrapper.fromJsonList<SliderEntity>(response, SliderModel.fromJson);
  }
}
