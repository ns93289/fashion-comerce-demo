import 'package:hive/hive.dart';

import '../../models/model_product.dart';
import 'hive_constants.dart';

final Box cartBox = Hive.box(hiveCartBox);

Future<void> initHiveBoxes() async {
  await Hive.openBox(hiveCartBox);
}

Future<void> putDataIntoCartBox(ModelProduct data) async {
  List<ModelProduct> cartData = getCartDataFromCartBox();
  int index = cartData.indexWhere((element) => element.productId == data.productId);
  if (index > -1) {
    cartData[index] = data;
  } else {
    cartData.add(data);
  }

  List<Map<String, dynamic>> jsonList = cartData.map((p) => p.toJson()).toList();
  await cartBox.put(hiveCartData, jsonList);
}

Future<void> removeItemFromCartBox(int productId) async {
  List<ModelProduct> cartData = getCartDataFromCartBox();
  cartData.removeWhere((element) => element.productId == productId);

  List<Map<String, dynamic>> jsonList = cartData.map((p) => p.toJson()).toList();
  await cartBox.put(hiveCartData, jsonList);
}

List<ModelProduct> getCartDataFromCartBox() {
  List<dynamic> jsonList = cartBox.get(hiveCartData, defaultValue: []);
  List<ModelProduct> cartData = jsonList.map((json) => ModelProduct.fromJson(Map<String, dynamic>.from(json))).toList();

  return cartData;
}
