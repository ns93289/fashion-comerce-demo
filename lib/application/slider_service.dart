import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/slider_entity.dart';
import '../domain/repositories/slider_repo.dart';
import '../main.dart';

class SliderService extends StateNotifier<AsyncValue<List<SliderEntity>>?> {
  final SliderRepo sliderRepo;

  SliderService(this.sliderRepo) : super(null);

  Future<void> callSliderApi({int action = 0, int type = 0}) async {
    state = const AsyncLoading();
    try {
      final result = await sliderRepo.getSliderData(action: action, type: type);
      if (result is ApiSuccess) {
        if (result.data is List<SliderEntity> && result.data.isNotEmpty) {
          state = AsyncData(result.data);
        } else {
          state = AsyncValue.error(language.emptyProductsMsg, StackTrace.empty);
        }
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callSliderApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }
}
