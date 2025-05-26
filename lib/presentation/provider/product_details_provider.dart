import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';
import 'home_provider.dart';

final productDetailsProvider = Provider.family<ModelProduct, int>((ref, productId) {
  return globalProductList.firstWhere((element) => element.productId == productId);
});

final productSizeProvider = StateProvider<num>((ref) => 0);

final productColorProvider = StateProvider<int>((ref) => 0);

final productQuantityProvider = StateProvider<int>((ref) => 1);
