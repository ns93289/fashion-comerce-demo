import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';

final List<ModelProductItem> favoriteProducts = [
  ModelProductItem(id: 1, name: "Creter Impact", category: "Men's Shoes", price: 77.65, favorite: true),
  ModelProductItem(id: 2, name: "Air Max Pre-Day", category: "Men's Shoes", price: 50, favorite: true),
  ModelProductItem(id: 3, name: "Air Office", category: "Men's Shoes", price: 66.35, favorite: true),
];

final favoriteProductListProvider = FutureProvider<List<ModelProductItem>>((ref) {
  return favoriteProducts;
});

favoriteUnFavoriteProduct(WidgetRef ref, ModelProductItem data) {
  var ModelProductItem(:favorite) = data;
  favorite = !favorite;
  if (favorite) {
    favoriteProducts.add(data);
  } else {
    favoriteProducts.removeWhere((element) => element.id == data.id);
  }
  // ignore: unused_result
  ref.refresh(favoriteProductListProvider);
}
