import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart_service.dart';
import '../../application/product_details_service.dart';
import '../../data/models/base_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repo_impl.dart';
import '../../data/repositories/product_details_repo_impl.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repositories/product_details_repo.dart';
import '../screens/cart/cart_screen.dart';
import 'navigation_provider.dart';

final productSizeProvider = StateProvider<int>((ref) => 0);

final productColorProvider = StateProvider<int>((ref) => 0);

final productQuantityProvider = StateProvider<int>((ref) => 1);

final productDetailsRepoProvider = Provider.autoDispose<ProductDetailsRepo>((ref) {
  return ProductDetailsRepoImpl();
});
final productDetailsServiceProvider = StateNotifierProvider.autoDispose
    .family<ProductDetailsService, AsyncValue<ProductDetailsEntity>?, ({int id, String? size, String? color})>((ref, args) {
      final service = ProductDetailsService(ref.watch(productDetailsRepoProvider));
      service.callProductDetailsApi(id: args.id, size: args.size, color: args.color);
      return service;
    });

final cartRepoProvider = Provider.autoDispose((ref) {
  return CartRepoImpl();
});
final cartServiceProvider = StateNotifierProvider<CartService, AsyncValue<dynamic>>((ref) {
  return CartService(ref.watch(cartRepoProvider));
});
final addToCartProvider = Provider.autoDispose.family<void, ({int productId, int productVariantId, String size, String color, bool isAddToCart})>((ref, args) {
  Future.microtask(() async {
    final CartModel? data = await ref
        .read(cartServiceProvider.notifier)
        .callAddToCartApi(productVariantId: args.productVariantId, productId: args.productId, quantity: 1);
    if (data != null) {
      ref.read(cartProductQuantityProvider.notifier).state = data.quantity;
      if (!args.isAddToCart) {
        ref.read(navigationServiceProvider).navigateTo(CartScreen());
      }
    }
  });
});
final removeProductCartProvider = Provider.autoDispose.family<void, ({int productId, int productVariantId, String size, String color})>((ref, args) {
  Future.microtask(() async {
    final BaseModel? data = await ref
        .read(cartServiceProvider.notifier)
        .callRemoveProductFromCartApi(productVariantId: args.productVariantId, productId: args.productId, type: 1);
    if (data != null) {
      var addedQuantity = ref.watch(cartProductQuantityProvider);
      ref.read(cartProductQuantityProvider.notifier).state = addedQuantity - 1;
    }
  });
});

final cartProductQuantityProvider = StateProvider.autoDispose<int>((ref) => 0);

final offerRemainingTimeProvider = StateProvider.autoDispose<int>((ref) => 0);

final offerTimerProvider = Provider.autoDispose((ref) {
  int remainingSeconds = remainingTimeToMidnight().inSeconds;
  Timer.periodic(const Duration(seconds: 1), (timer) {
    if (remainingSeconds > 0) {
      remainingSeconds--;
      ref.read(offerRemainingTimeProvider.notifier).state = remainingSeconds;
    } else {
      timer.cancel();
    }
  });
});

Duration remainingTimeToMidnight() {
  final now = DateTime.now();
  final target = DateTime(now.year, now.month, now.day, 23, 59, 0);

  // If already past 23:59:00 today, return zero duration
  return now.isAfter(target) ? Duration.zero : target.difference(now);
}
