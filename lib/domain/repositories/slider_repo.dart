import '../../data/dataSources/remote/api_reponse.dart';
import '../entities/slider_entity.dart';

abstract class SliderRepo {
  Future<ApiResponse<dynamic>> getSliderData({int action = 0, int type = 0});
}
