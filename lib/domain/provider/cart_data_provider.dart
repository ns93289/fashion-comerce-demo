import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/tools.dart';
import '../../main.dart';
import '../../data/models/model_key_value.dart';
import '../../data/models/cart_model.dart';

final checkoutDataProvider = StateProvider<CartModel>((ref) {
  return CartModel(deliveryCharge: 2, itemTotal: 77.65, total: 79.65);
});

final checkoutInvoiceProvider = StateProvider<List<ModelKeyValue>>((ref) {
  return [
    ModelKeyValue(language.itemTotal, 77.65.withCurrency),
    ModelKeyValue(language.deliveryCharge, 2.withCurrency),
    ModelKeyValue(language.total, 79.65.withCurrency, setBold: true),
  ];
});
