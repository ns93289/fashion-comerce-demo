import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/orderPlaced/order_placed_screen.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../application/place_order_service.dart';
import '../../application/wallet_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/tools.dart';
import '../../data/models/base_model.dart';
import '../../data/repositories/place_order_repo_impl.dart';
import '../../data/repositories/wallet_repo_impl.dart';
import '../../domain/repositories/wallet_repo.dart';
import '../../main.dart';

final walletRepoProvider = Provider.autoDispose<WalletRepo>((ref) {
  return WalletRepoImpl();
});

final walletServiceProvider = StateNotifierProvider<WalletService, AsyncValue<dynamic>>((ref) {
  final service = WalletService(ref.watch(walletRepoProvider));
  service.callWalletBalanceApi();
  return service;
});

final placeOrdeRepoProvider = Provider.autoDispose<PlaceOrderRepoImpl>((ref) {
  return PlaceOrderRepoImpl();
});
final placeOrderServiceProvider = StateNotifierProvider<PlaceOrderService, AsyncValue<dynamic>>((ref) {
  return PlaceOrderService(ref.watch(placeOrdeRepoProvider));
});
final placeOrderProvider = Provider.family<void, BuildContext>((ref, context) {
  Future.microtask(() async {
    int paymentType = ref.watch(paymentTypePro);
    int addressId = getAddressFromAddressBox()?.addressId ?? 0;
    BaseModel? data = await ref.read(placeOrderServiceProvider.notifier).callPlaceOrderApi(paymentType: paymentType, addressId: addressId);
    if (data != null) {
      setDataIntoCartBox(0);
      if (!context.mounted) return;
      openScreen(context, OrderPlacedScreen());
    }
  });
});

final paymentTypePro = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final walletAmountPro = StateProvider.autoDispose<num>((ref) {
  return 1000;
});

final makePaymentPro = FutureProvider.family<bool, ({int paymentType, num orderAmount})>((ref, args) async {
  switch (args.paymentType) {
    case 0:
      {
        openSimpleSnackBar(language.selectPayment);
      }
    case PaymentType.wallet:
      {}
    default:
      {}
  }
  return true;
});
