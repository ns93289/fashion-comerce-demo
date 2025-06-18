import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/brands_entity.dart';
import '../domain/repositories/brands_repo.dart';
import '../main.dart';

class BrandsService extends StateNotifier<AsyncValue<List<BrandsEntity>>?> {
  final BrandsRepo brandsRepo;

  BrandsService(this.brandsRepo) : super(null);

  Future<void> callBrandsApi({bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await brandsRepo.getBrands();
      if (result is ApiSuccess) {
        if (result.data is List<BrandsEntity> && result.data.isNotEmpty) {
          state = AsyncData(result.data);
        } else {
          state = AsyncValue.error(language.emptyProductsMsg, StackTrace.empty);
        }
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callBrandsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }
}
