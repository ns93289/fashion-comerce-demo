import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';
import 'home_provider.dart';

final List<ModelProduct> favoriteProducts = [];

final favoriteProductListProvider = FutureProvider<List<ModelProduct>>((ref) {
  return favoriteProducts;
});

favoriteUnFavoriteProduct(WidgetRef ref, ModelProduct data) {
  var ModelProduct(:favorite) = data;
  favorite = !favorite;
  globalProductList.where((element) => element.productId == data.productId).forEach((element) => element.favorite = favorite);
  // ignore: unused_result
  ref.refresh(allProductProvider);

  if (favorite) {
    favoriteProducts.add(data);
  } else {
    favoriteProducts.removeWhere((element) => element.productId == data.productId);
  }
  // ignore: unused_result
  ref.refresh(favoriteProductListProvider);
}
