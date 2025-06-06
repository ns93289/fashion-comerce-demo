import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/extensions.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../data/models/model_product.dart';
import '../../main.dart';
import '../../data/models/model_key_value.dart';

final checkoutDataProvider = StateProvider<num>((ref) {
  List<ModelProduct> cartData = getCartDataFromCartBox();
  num itemTotal = 0;
  for (var element in cartData) {
    itemTotal += element.productPrice;
  }

  return itemTotal + 2;
});

final checkoutInvoiceProvider = StateProvider<List<ModelKeyValue>>((ref) {
  List<ModelProduct> cartData = getCartDataFromCartBox();
  num itemTotal = 0;
  for (var element in cartData) {
    itemTotal += element.productPrice;
  }

  return [
    ModelKeyValue("${language.subTotal}-", itemTotal.withCurrency),
    ModelKeyValue("${language.deliveryCharge}-", 2.withCurrency),
    ModelKeyValue("${language.total}-", (itemTotal + 2).withCurrency, setBold: true, setDivider: true),
  ];
});

final deliveryTypeProvider = StateProvider.autoDispose<int>((ref) {
  return DeliveryTypes.fast;
});
