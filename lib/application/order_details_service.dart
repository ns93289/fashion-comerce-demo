import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/order_details_entity.dart';
import '../domain/repositories/order_details_repo.dart';

class OrderDetailsService extends StateNotifier<AsyncValue<OrderDetailsEntity?>> {
  final OrderDetailsRepo orderDetailsRepo;

  OrderDetailsService(this.orderDetailsRepo) : super(const AsyncValue.data(null));

  Future<void> callOrderDetailsApi({required int orderId}) async {
    state = const AsyncValue.loading();
    try {
      final response = await orderDetailsRepo.fetchORderDetails(orderId: orderId);
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
      } else if (response is ApiError) {
        state = AsyncValue.error(response.errorData.message, StackTrace.empty);
      } else {
        state = const AsyncValue.error("Api response is neither success nor error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callOrderDetailsApi>>>", e.toString());
      state = AsyncValue.error(e, st);
    }
  }
}
