import 'package:hive/hive.dart';

import '../../models/model_address.dart';
import '../../models/order_history_model.dart';
import '../../models/search_model.dart';
import 'hive_constants.dart';

final Box cartBox = Hive.box(hiveCartBox);
final Box orderBox = Hive.box(hiveOrderBox);
final Box userBox = Hive.box(hiveUserBox);
final Box addressBox = Hive.box(hiveAddressBox);
final Box recentSearchBox = Hive.box(hiveRecentSearchBox);

Future<void> initHiveBoxes() async {
  await Hive.openBox(hiveCartBox);
  await Hive.openBox(hiveOrderBox);
  await Hive.openBox(hiveUserBox);
  await Hive.openBox(hiveAddressBox);
  await Hive.openBox(hiveRecentSearchBox);
}

Future<void> putDataInAddressBox(ModelAddress address) async {
  await addressBox.put(hiveAddressData, address.toJson());
}

ModelAddress? getAddressFromAddressBox() {
  Map<dynamic, dynamic>? json = addressBox.get(hiveAddressData, defaultValue: null);
  return json == null ? null : ModelAddress.fromJson(json);
}

Future<void> addDataIntoCartBox(int count) async {
  int cartCount = getCartCountFromCartBox();
  await cartBox.put(hiveCartData, cartCount + count);
}

Future<void> setDataIntoCartBox(int count) async {
  await cartBox.put(hiveCartData, count);
}

int getCartCountFromCartBox() {
  return cartBox.get(hiveCartData, defaultValue: 0) ?? 0;
}

List<OrderHistoryModel> getOrderHistoryDataFromOrderBox() {
  List<dynamic> jsonList = orderBox.get(hiveOrderData, defaultValue: []);
  List<OrderHistoryModel> orderData = jsonList.map((json) => OrderHistoryModel.fromJson(Map<String, dynamic>.from(json))).toList();

  return orderData;
}

Future<void> putDataIntoRecentSearchBox(SearchModel data) async {
  List<SearchModel> recentData = getRecentSearchFromRecentBox();
  int index = recentData.indexWhere((element) => element.searchString == data.searchString.toLowerCase());
  if (index > -1) {
    recentData[index] = data;
  } else {
    recentData.add(data);
  }

  if (recentData.length > 5) {
    recentData.removeAt(0);
  }

  List<Map<String, dynamic>> jsonList = recentData.map((p) => p.toJson()).toList();
  await recentSearchBox.put(hiveRecentSearchData, jsonList);
}

List<SearchModel> getRecentSearchFromRecentBox() {
  List<dynamic> jsonList = recentSearchBox.get(hiveRecentSearchData, defaultValue: []);
  List<SearchModel> recentData = jsonList.map((json) => SearchModel.fromJson(Map<String, dynamic>.from(json))).toList();

  return recentData;
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

bool getBoolDataFromUserBox({required String key}) {
  return userBox.get(key, defaultValue: false) ?? false;
}

Future<void> clearAllBoxes() async {
  // await userBox.clear();
  putDataInUserBox(key: hiveUserIsVerified, value: false);
  putDataInUserBox(key: hiveProfilePicture, value: "");
  await orderBox.clear();
  await cartBox.clear();
  await userBox.clear();
  await addressBox.clear();
  await recentSearchBox.clear();
}
