import '../../data/dataSources/remote/api_reponse.dart';
import '../entities/slider_entity.dart';

abstract class SliderRepo {
  Future<ApiResponse<List<SliderEntity>>> getSliderData({bool isForMale = false, bool isForFemale = false, bool isForKids = false});
}
