import 'package:hive/hive.dart';

import '../../models/model_address.dart';
import 'hive_constants.dart';

final Box cartBox = Hive.box(hiveCartBox);
final Box userBox = Hive.box(hiveUserBox);
final Box addressBox = Hive.box(hiveAddressBox);
final Box recentSearchBox = Hive.box(hiveRecentSearchBox);

Future<void> initHiveBoxes() async {
  await Hive.openBox(hiveCartBox);
  await Hive.openBox(hiveUserBox);
  await Hive.openBox(hiveAddressBox);
  await Hive.openBox(hiveRecentSearchBox);
}

Future<void> putDataInAddressBox(ModelAddress address) async {
  await addressBox.put(hiveAddressData, address.toJson());
}

Future<void> checkAndChangeAddressBox(ModelAddress newAddress) async {
  ModelAddress? address = getAddressFromAddressBox();
  if (address?.addressId == newAddress.addressId) {
    await addressBox.put(hiveAddressData, newAddress.toJson());
  }
}

Future<void> checkAndDeleteAddressBox(int addressId) async {
  ModelAddress? address = getAddressFromAddressBox();
  if (address?.addressId == addressId) {
    await addressBox.put(hiveAddressData, null);
  }
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

Future<void> putDataIntoRecentSearchBox(String data) async {
  List<String> recentData = getRecentSearchFromRecentBox();
  int index = recentData.indexWhere((element) => element == data.toLowerCase());
  if (index > -1) {
    recentData[index] = data.toLowerCase();
  } else {
    recentData.add(data.toLowerCase());
  }

  if (recentData.length > 5) {
    recentData.removeAt(0);
  }

  await recentSearchBox.put(hiveRecentSearchData, recentData);
}

List<String> getRecentSearchFromRecentBox() {
  List<String> jsonList = recentSearchBox.get(hiveRecentSearchData, defaultValue: []).cast<String>() ?? [];

  return jsonList;
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
  await cartBox.clear();
  await userBox.clear();
  await addressBox.clear();
  await recentSearchBox.clear();
}

Future<void> clearUserBox() async {
  await userBox.clear();
}
