import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/product_service.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

final productRepoProvider = Provider.autoDispose<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final favoriteListServiceProvider = StateNotifierProvider<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  final service = ProductService(ref.watch(productRepoProvider));
  service.callFavoriteProductsApi();
  return service;
});

//Favorite/Un-favorite for pagination
/*void toggleFavorite({
  required WidgetRef ref,
  required int productId,
}) async {
  final controller = ref.read(pagingControllerProvider);

  // 1. Get current items
  final currentItems = controller.value.itemList;
  if (currentItems == null) return;

  // 2. Find and update item
  final updatedItems = currentItems.map((item) {
    if (item.id == productId) {
      final newFav = !item.isFavorite;

      // 3. Call API to update favorite
      ref.read(productRepoProvider).toggleFavoriteOnServer(productId, newFav);

      return item.copyWith(isFavorite: newFav);
    }
    return item;
  }).toList();

  // 4. Update controller state locally
  controller.value = controller.value.copyWith(itemList: updatedItems);
}*/

