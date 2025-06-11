import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/extensions.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../data/repositories/cart_repo_impl.dart';
import '../../main.dart';
import '../../data/models/model_key_value.dart';

final cartRepoProvider = Provider.autoDispose((ref) {
  return CartRepoImpl();
});
final cartDetailsServiceProvider = StateNotifierProvider.autoDispose<CartService, AsyncValue<dynamic>>((ref) {
  return CartService(ref.watch(cartRepoProvider));
});
final cartDetailsProvider = Provider.autoDispose((ref) {
  Future.microtask(() async {
    final data = await ref.read(cartDetailsServiceProvider.notifier).callGetCartDetailsApi();
    if (data != null) {
      setDataIntoCartBox(data.products.length);
      ref.read(checkoutDataProvider.notifier).state = data.total;
      ref.read(checkoutInvoiceProvider.notifier).state = [
        ModelKeyValue("${language.subTotal}-", data.subtotal.withCurrency),
        ModelKeyValue("${language.total}-", data.total.withCurrency, setBold: true, setDivider: true),
      ];
    }
  });
});
final cartServiceProvider = StateNotifierProvider<CartService, AsyncValue<dynamic>>((ref) {
  return CartService(ref.watch(cartRepoProvider));
});
final addToCartProvider = Provider.autoDispose.family<void, ({int productId, int productVariantId, String size, String color})>((ref, args) {
  Future.microtask(() async {
    final data = await ref.read(cartServiceProvider.notifier).callAddToCartApi(productVariantId: args.productVariantId, productId: args.productId, quantity: 1);
    if (data != null) {
      ref.read(cartDetailsProvider);
    }
  });
});
final removeProductCartProvider = Provider.autoDispose.family<void, ({int productId, int productVariantId, String size, String color})>((ref, args) {
  Future.microtask(() async {
    final data = await ref
        .read(cartServiceProvider.notifier)
        .callRemoveProductFromCartApi(productVariantId: args.productVariantId, productId: args.productId, type: 1);
    if (data != null) {
      ref.read(cartDetailsProvider);
    }
  });
});
final checkoutDataProvider = StateProvider<num>((ref) {
  return 0;
});

final checkoutInvoiceProvider = StateProvider<List<ModelKeyValue>>((ref) {
  return [];
});

final deliveryTypeProvider = StateProvider.autoDispose<int>((ref) {
  return DeliveryTypes.fast;
});
