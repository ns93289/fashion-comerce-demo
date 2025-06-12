import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/order_history_entity.dart';
import '../domain/repositories/order_history_repo.dart';

class OrderHistoryService extends StateNotifier<AsyncValue<List<OrderHistoryEntity>?>> {
  final OrderHistoryRepo orderHistoryRepo;

  OrderHistoryService(this.orderHistoryRepo) : super(AsyncValue.data(null));

  Future<List<OrderHistoryEntity>?> callOrderHistoryApi({required int page}) async {
    state = AsyncValue.loading();
    try {
      final response = await orderHistoryRepo.getOrderHistoryData(page: page);
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else if (response is ApiError) {
        state = AsyncValue.error(response.errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callOrderHistoryApi>>>", e.toString());
      state = AsyncValue.error(e, st);
    }
    return null;
  }
}


