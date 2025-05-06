import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';

final productFiltersProvider = Provider<List<ModelProductFilter>>((ref) {
  List<ModelProductFilter> filters = [
    ModelProductFilter(id: 1, categoryName: "Lifestyle"),
    ModelProductFilter(id: 2, categoryName: "Basketball"),
    ModelProductFilter(id: 3, categoryName: "Running"),
    ModelProductFilter(id: 4, categoryName: "Office"),
  ];
  return filters;
});

final newProductProvider = Provider<List<ModelProductItem>>((ref) {
  return [
    ModelProductItem(id: 1, name: "Creter Impact", category: "Men's Shoes", price: 77.65),
    ModelProductItem(id: 2, name: "Air Max Pre-Day", category: "Men's Shoes", price: 77.65),
    ModelProductItem(id: 3, name: "Air Office", category: "Men's Shoes", price: 77.65),
  ];
});

final popularProductProvider = Provider<List<ModelProductItem>>((ref) {
  return [
    ModelProductItem(id: 1, name: "Creter Impact", category: "Men's Shoes", price: 77.65),
    ModelProductItem(id: 2, name: "Air Max Pre-Day", category: "Men's Shoes", price: 77.65),
    ModelProductItem(id: 3, name: "Air Office", category: "Men's Shoes", price: 77.65),
  ];
});
