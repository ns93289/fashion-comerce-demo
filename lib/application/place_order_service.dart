import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../data/models/base_model.dart';
import '../domain/repositories/place_order_repo.dart';

class PlaceOrderService extends StateNotifier<AsyncValue<BaseModel?>> {
  final PlaceOrderRepo placeOrderRepo;

  PlaceOrderService(this.placeOrderRepo) : super(AsyncValue.data(null));

  Future<BaseModel?> callPlaceOrderApi({required int paymentType, required int addressId}) async {
    state = AsyncValue.loading();
    try {
      final response = await placeOrderRepo.placeOrder(paymentType: paymentType, addressId: addressId);
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else if (response is ApiError) {
        state = AsyncValue.error(response.errorData.message, StackTrace.empty);
      } else {
        state = AsyncValue.error("Api response neither success nor error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callPlaceOrderApi>>>", e.toString());
      state = AsyncValue.error(e, st);
    }
    return null;
  }
}
