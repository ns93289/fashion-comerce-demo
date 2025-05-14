import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';
import 'home_provider.dart';

final List<ModelProduct> favoriteProducts = [];

final favoriteProductListProvider = FutureProvider<List<ModelProduct>>((ref) {
  return favoriteProducts;
});

final favoriteUnFavorite = Provider.family<void, ModelProduct>((ref, data) {
  var ModelProduct(:favorite) = data;
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
