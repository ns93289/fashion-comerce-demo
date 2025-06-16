import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/product_details_entity.dart';
import '../domain/repositories/product_details_repo.dart';

class ProductDetailsService extends StateNotifier<AsyncValue<ProductDetailsEntity>?> {
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsService(this.productDetailsRepo) : super(null);

  Future<void> callProductDetailsApi({required int id, String? size, String? color}) async {
    state = const AsyncLoading();
    try {
      final result = await productDetailsRepo.getProductDetails(id: id, size: size, color: color);
      if (result is ApiSuccess) {
        state = AsyncData(result.data);
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callProductDetailsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }
}
