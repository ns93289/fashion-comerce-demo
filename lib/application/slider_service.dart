import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/slider_entity.dart';
import '../domain/repositories/slider_repo.dart';

class SliderService extends StateNotifier<AsyncValue<List<SliderEntity>>?> {
  final SliderRepo sliderRepo;

  SliderService(this.sliderRepo) : super(null);

  Future<void> callSliderApi({bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await sliderRepo.getSliderData(isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (result is ApiSuccess) {
        state = AsyncData((result as ApiSuccess).data);
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callSliderApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }
}
