import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/address_service.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/address_repo_impl.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repo.dart';
import '../../presentation/dialogs/common_dialog.dart';

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

final landmarkTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final receiverNameTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final receiverNumberTECProvider = Provider.autoDispose<TextEditingController>((ref) {
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

final addressTypesProvider = Provider.autoDispose<List<AddressTypeEntity>>((ref) {
  return [
    AddressTypeEntity(addressType: AddressTypes.home, title: language.home),
    AddressTypeEntity(addressType: AddressTypes.work, title: language.work),
    AddressTypeEntity(addressType: AddressTypes.family, title: language.familyOrFriend),
    AddressTypeEntity(addressType: AddressTypes.other, title: language.other),
  ];
});

final addressTypeSelectProvider = StateProvider.autoDispose<int>((ref) {
  return AddressTypes.home;
});

final addressRepoProvider = Provider.autoDispose<AddressRepo>((ref) {
  return AddressRepoImpl();
});

final addressServiceProvider = StateNotifierProvider<AddressService, AsyncValue<dynamic>>((ref) {
  return AddressService(ref.watch(addressRepoProvider));
});

final getAddressServiceProvider = StateNotifierProvider<AddressService, AsyncValue<dynamic>>((ref) {
  return AddressService(ref.watch(addressRepoProvider));
});

final addAddressProvider = Provider.autoDispose<void>((ref) {
  final houseName = ref.read(houseNameTECProvider).text;
  final houseNo = ref.read(houseNoTECProvider).text;
  final street = ref.read(streetTECProvider).text;
  final addressLine1 = ref.read(landmarkTECProvider).text;
  // final addressLine2 = ref.read(addressLine2TECProvider).text;
  final city = ref.read(cityTECProvider).text;
  final state = ref.read(stateTECProvider).text;
  final pinCode = ref.read(pinCodeTECProvider).text;
  final addressType = ref.read(addressTypeSelectProvider);

  AddressEntity address = AddressEntity(
    addressType: addressType,
    houseName: houseName,
    houseNo: houseNo,
    street: street,
    addressLine1: addressLine1,
    // addressLine2: addressLine2,
    city: city,
    state: state,
    pinCode: pinCode,
  );
  Future.microtask(() {
    ref.read(addressServiceProvider.notifier).callAddAddressApi(address: address);
  });
});

final editAddressProvider = Provider.autoDispose.family<void, int>((ref, addressId) {
  final houseName = ref.read(houseNameTECProvider).text;
  final houseNo = ref.read(houseNoTECProvider).text;
  final street = ref.read(streetTECProvider).text;
  final addressLine1 = ref.read(landmarkTECProvider).text;
  // final addressLine2 = ref.read(addressLine2TECProvider).text;
  final city = ref.read(cityTECProvider).text;
  final state = ref.read(stateTECProvider).text;
  final pinCode = ref.read(pinCodeTECProvider).text;
  final addressType = ref.read(addressTypeSelectProvider);

  AddressEntity address = AddressEntity(
    addressId: addressId,
    addressType: addressType,
    houseName: houseName,
    houseNo: houseNo,
    street: street,
    addressLine1: addressLine1,
    // addressLine2: addressLine2,
    city: city,
    state: state,
    pinCode: pinCode,
  );
  Future.microtask(() {
    ref.read(addressServiceProvider.notifier).callEditAddressApi(address: address);
  });
});

final deleteAddressProvider = Provider.family<void, ({BuildContext context, int addressId})>((ref, args) {
  showDialog(
    context: args.context,
    builder: (context) {
      return CommonDialog(
        title: language.sureToDeleteAddress,
        onPositiveClick: () {
          Future.microtask(() {
            ref.read(addressServiceProvider.notifier).callDeleteAddressApi(addressId: args.addressId).then((value) {
              ref.read(getAddressServiceProvider.notifier).callGetAddressApi();
              if (!context.mounted) return;
              Navigator.pop(context);
            });
          });
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
