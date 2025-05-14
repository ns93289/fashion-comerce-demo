import 'package:fashion_comerce_demo/main.dart';
import 'package:hive/hive.dart';

import '../../models/model_address.dart';
import '../../models/model_product.dart';
import '../../models/order_history_model.dart';
import 'hive_constants.dart';

final Box cartBox = Hive.box(hiveCartBox);
final Box orderBox = Hive.box(hiveOrderBox);
final Box userBox = Hive.box(hiveUserBox);
final Box addressBox = Hive.box(hiveAddressBox);

Future<void> initHiveBoxes() async {
  await Hive.openBox(hiveCartBox);
  await Hive.openBox(hiveOrderBox);
  await Hive.openBox(hiveUserBox);
  await Hive.openBox(hiveAddressBox);
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

Future<int> clearCartAndPutOrderData() async {
  List<ModelProduct> cartList = getCartDataFromCartBox();
  List<int> productIds = [];
  int orderQuantities = 0;
  List<String> productNames = [];
  num orderAmount = 0;
  for (var element in cartList) {
    productIds.add(element.productId);
    productNames.add(element.productName);
    orderAmount += element.productPrice;
    orderQuantities += element.selectedQuantity;
  }
  List<OrderHistoryItem> orderList = getOrderHistoryDataFromOrderBox();
  int orderId = 1;
  if (orderList.isNotEmpty) {
    orderId = orderList.last.orderId + 1;
  }
  orderList.add(
    OrderHistoryItem(
      orderId: orderId,
      deliveryAddress: "101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India",
      productName: productNames.toString(),
      orderAmount: orderAmount,
      orderQuantity: orderQuantities,
      productIdList: productIds,
      orderStatusMsg: language.orderPlaced,
      orderedTime: DateTime.now().toString(),
    ),
  );
  List<Map<String, dynamic>> jsonList = orderList.map((p) => p.toJson()).toList();
  await orderBox.put(hiveOrderData, jsonList);
  await cartBox.clear();
  return orderId;
}

List<OrderHistoryItem> getOrderHistoryDataFromOrderBox() {
  List<dynamic> jsonList = orderBox.get(hiveCartData, defaultValue: []);
  List<OrderHistoryItem> orderData = jsonList.map((json) => OrderHistoryItem.fromJson(Map<String, dynamic>.from(json))).toList();

  return orderData;
}

Future<void> putDataInUserBox({required String key, dynamic value}) async {
  await userBox.put(key, value);
}

String getStringDataFromUserBox({required String key}) {
  return userBox.get(key) ?? "";
}

int getIntDataFromUserBox({required String key}) {
  return userBox.get(key, defaultValue: 0) ?? 0;
}

List<ModelAddress> getAddressDataFromAddressBox() {
  List<dynamic> jsonList = addressBox.get(hiveAddressData, defaultValue: []);
  List<ModelAddress> addressData = jsonList.map((json) => ModelAddress.fromJson(Map<String, dynamic>.from(json))).toList();
  return addressData;
}

Future<void> putDataInAddressBox({required ModelAddress data}) async {
  List<ModelAddress> addressData = getAddressDataFromAddressBox();
  int index = addressData.indexWhere((element) => element.addressId == data.addressId);
  if (index > -1) {
    addressData[index] = data;
  } else {
    data.addressId = addressData.length + 1;
    addressData.add(data);
  }
  List<Map<String, dynamic>> jsonList = addressData.map((p) => p.toJson()).toList();
  await addressBox.put(hiveAddressData, jsonList);
}

Future<void> deleteAddressFromAddressBox(int addressId) async {
  List<ModelAddress> addressData = getAddressDataFromAddressBox();
  addressData.removeWhere((element) => element.addressId == addressId);
  List<Map<String, dynamic>> jsonList = addressData.map((p) => p.toJson()).toList();
  await addressBox.put(hiveAddressData, jsonList);
}

Future<void> clearAllBoxes() async {
  await userBox.clear();
  await orderBox.clear();
  await cartBox.clear();
}
