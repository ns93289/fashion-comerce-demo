import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../data/models/base_model.dart';
import '../data/models/cart_model.dart';
import '../domain/entities/cart_preview_entity.dart';
import '../domain/repositories/cart_repo.dart';

class CartService extends StateNotifier<AsyncValue<dynamic>> {
  final CartRepo cartRepo;

  CartService(this.cartRepo) : super(AsyncValue.data(null));

  Future<CartModel?> callAddToCartApi({required int productVariantId, required int productId, required int quantity}) async {
    state = AsyncValue.loading();
    try {
      final response = await cartRepo.addToCart(productVariantId: productVariantId, productId: productId, quantity: quantity);
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else if (response is ApiError) {
        state = AsyncValue.error(response.errorData.message, StackTrace.empty);
      } else {
        state = AsyncValue.error("Api response is neither success nor error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callAddToCartApi>>>", e.toString());
      state = AsyncValue.error(e.toString(), st);
    }
    return null;
  }

  Future<CartPreviewEntity?> callGetCartDetailsApi() async {
    state = AsyncValue.loading();
    try {
      final response = await cartRepo.getCartDetails();
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else if (response is ApiError) {
        state = AsyncValue.error(response.errorData.message, StackTrace.empty);
      } else {
        state = AsyncValue.error("Api response is neither success nor error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callGetCartDetailsApi>>>", e.toString());
      state = AsyncValue.error(e.toString(), st);
    }
    return null;
  }

  Future<BaseModel?> callRemoveProductFromCartApi({required int productVariantId, required int productId, required int type}) async {
    state = AsyncValue.loading();
    try {
      final response = await cartRepo.removeProductFromCart(productVariantId: productVariantId, productId: productId, type: type);
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else if (response is ApiError) {
        state = AsyncValue.error(response.errorData.message, StackTrace.empty);
      } else {
        state = AsyncValue.error("Api response is neither success nor error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callRemoveProductFromCartApi>>>", e.toString());
      state = AsyncValue.error(e.toString(), st);
    }
    return null;
  }
}
