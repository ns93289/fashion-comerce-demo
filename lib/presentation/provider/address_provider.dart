import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../data/models/model_address.dart';
import '../../presentation/dialogs/common_dialog.dart';

final addressListProvider = StateProvider.autoDispose<List<ModelAddress>>((ref) {
  return getAddressDataFromAddressBox();
});

final houseNameTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final houseNoTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final addressLine1TECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final addressLine2TECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final streetTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final cityTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final stateTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final pinCodeTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final addressTypeProvider = StateProvider.autoDispose<int>((ref) {
  return AddressTypes.home;
});

final deleteAddressProvider = Provider.family<void, ({BuildContext context, int addressId})>((ref, args) {
  showDialog(
    context: args.context,
    builder: (context) {
      return CommonDialog(
        title: language.sureToDeleteAddress,
        onPositiveClick: () {
          deleteAddressFromAddressBox(args.addressId).then((value) => ref.read(addressListProvider.notifier).state = getAddressDataFromAddressBox());
          Navigator.pop(context);
        },
        negativeText: language.cancel,
        positiveText: language.delete,
        onNegativeClick: () {
          Navigator.pop(context);
        },
      );
    },
  );
});

final addressFormKey = GlobalKey<FormState>();
