import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product_entity.dart';
import 'home_provider.dart';

final List<ProductEntity> favoriteProducts = [];

final favoriteProductListProvider = FutureProvider<List<ProductEntity>>((ref) {
  return favoriteProducts;
});

final favoriteUnFavorite = Provider.family<void, ProductEntity>((ref, data) {
  var ProductEntity(:favorite) = data;
  favorite = !favorite;
  globalProductList.where((element) => element.productId == data.productId).forEach((element) => element.favorite = favorite);
  ref.read(allProductProvider.notifier).refreshData();

  if (favorite) {
    favoriteProducts.add(data);
  } else {
    favoriteProducts.removeWhere((element) => element.productId == data.productId);
  }
  // ignore: unused_result
  ref.refresh(favoriteProductListProvider);
});
