import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/repositories/home_repo.dart';

class HomeService extends StateNotifier<AsyncValue<dynamic>> {
  final HomeRepo homeRepo;

  HomeService(this.homeRepo) : super(AsyncValue.data(null));

  Future<void> callHomeCategories() async {
    state = const AsyncLoading();
    try {
      final res = await homeRepo.getHomeCategories();
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else if (res is ApiError) {
        state = AsyncValue.error(res.errorData.message, StackTrace.empty);
      } else {
        state = const AsyncValue.error("Api response is neither success or error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callHomeCategories>>>", e.toString());
      state = AsyncError(e, st);
    }
  }
}
