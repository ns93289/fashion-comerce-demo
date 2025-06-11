import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart_service.dart';
import '../../application/product_details_service.dart';
import '../../core/utils/tools.dart';
import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repo_impl.dart';
import '../../data/repositories/product_details_repo_impl.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repositories/product_details_repo.dart';
import '../screens/cart/cart_screen.dart';

final productSizeProvider = StateProvider<int>((ref) => 0);

final productColorProvider = StateProvider<int>((ref) => 0);

final productQuantityProvider = StateProvider<int>((ref) => 1);

final productDetailsRepoProvider = Provider.autoDispose<ProductDetailsRepo>((ref) {
  return ProductDetailsRepoImpl();
});
final productDetailsServiceProvider = StateNotifierProvider.autoDispose
    .family<ProductDetailsService, AsyncValue<ProductDetailsEntity>?, ({int id, String size, String color})>((ref, args) {
      final service = ProductDetailsService(ref.watch(productDetailsRepoProvider));
      service.callProductDetailsApi(id: args.id, size: args.size, color: args.color);
      return service;
    });
final productDetailsProvider = Provider.autoDispose.family<void, ({int id, String size, String color})>((ref, args) {
  Future.microtask(() {
    ref.read(productDetailsServiceProvider((id: args.id, size: args.size, color: args.color)));
  });
});

final cartRepoProvider = Provider.autoDispose((ref) {
  return CartRepoImpl();
});
final cartServiceProvider = StateNotifierProvider<CartService, AsyncValue<dynamic>>((ref) {
  return CartService(ref.watch(cartRepoProvider));
});
final addToCartProvider = Provider.autoDispose
    .family<void, ({BuildContext context, int productId, int productVariantId, String size, String color, bool isAddToCart})>((ref, args) {
      Future.microtask(() async {
        final CartModel? data = await ref
            .read(cartServiceProvider.notifier)
            .callAddToCartApi(productVariantId: args.productVariantId, productId: args.productId, quantity: 1);
        if (data != null) {
          ref.read(cartProductQuantityProvider.notifier).state = data.quantity;
          if (!args.isAddToCart) {
            openScreen(args.context, CartScreen());
          }
        }
      });
    });
final removeProductCartProvider = Provider.autoDispose.family<void, ({int productId, int productVariantId, String size, String color})>((ref, args) {
  Future.microtask(() async {
    final CartModel? data = await ref
        .read(cartServiceProvider.notifier)
        .callRemoveProductFromCartApi(productVariantId: args.productVariantId, productId: args.productId, type: 1);
    if (data != null) {
      ref.read(cartProductQuantityProvider.notifier).state = data.quantity;
    }
  });
});

final cartProductQuantityProvider = StateProvider.autoDispose<int>((ref) => 0);
