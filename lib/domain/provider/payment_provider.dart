import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/tools.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../main.dart';
import '../../presentation/screens/orderPlaced/order_placed_screen.dart';

final paymentTypePro = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final walletAmountPro = StateProvider.autoDispose<num>((ref) {
  return 1000;
});

final makePaymentPro = FutureProvider.family<bool, ({int paymentType, num orderAmount, num walletAmount})>((ref, args) async {
  switch (args.paymentType) {
    case 0:
      {
        openSimpleSnackBar(language.selectPayment);
      }
    case PaymentType.wallet:
      {
        if (args.orderAmount <= args.walletAmount) {
          int orderId = await clearCartAndPutOrderData();
          openScreenWithClearStack(navigatorKey.currentContext!, OrderPlacedScreen(orderId: orderId, orderNo: "ASD12345"));
        } else {}
      }
    default:
      {
        int orderId = await clearCartAndPutOrderData();
        openScreenWithClearStack(navigatorKey.currentContext!, OrderPlacedScreen(orderId: orderId, orderNo: "ASD12345"));
      }
  }
  return true;
});
