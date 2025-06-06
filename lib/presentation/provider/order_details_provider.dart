import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/tools.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../data/dataSources/remote/api_reponse.dart';
import '../../data/models/model_order_details.dart';
import '../../data/models/order_history_model.dart';
import '../bottomSheets/product_status_bottom_sheet.dart';
import 'home_provider.dart';

final orderDetailsFP = FutureProvider.autoDispose.family<ApiResponse<ModelOrderDetails>, int>((ref, orderId) {
  List<OrderHistoryItem> orderItems = getOrderHistoryDataFromOrderBox();
  OrderHistoryItem? firstItem = orderItems.where((element) => element.orderId == orderId).firstOrNull;
  List<int> productIds = firstItem?.productIdList ?? [];
  String orderedTime = getFormatedDate(firstItem?.orderedTime ?? "");
  String deliveryTime = getFormatedDate(getDateTimeObjFromString(firstItem?.orderedTime ?? "").add(Duration(days: 2)).toString());

  ModelOrderDetails modelOrderDetails = ModelOrderDetails(
    orderId: orderId,
    deliveryAddress: "101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India",
    orderNo: "ASD123456",
    orderStatus: 1,
    orderTime: orderedTime,
    packedTime: orderedTime,
    deliveryTime: deliveryTime,
    totalAmount: firstItem?.orderAmount ?? 0,
    orderedProducts: globalProductList.where((element) => productIds.contains(element.productId)).toList(),
  );

  return ApiSuccess(modelOrderDetails);
});

final openProductStatusBSProvider = Provider.autoDispose.family<void, ({ModelOrderDetails orderDetails, BuildContext context})>((ref, args) {
  showModalBottomSheet(
    context: args.context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return ProductStatusBottomSheet(orderNo: args.orderDetails.orderNo, orderTime: args.orderDetails.orderTime);
    },
  );
});
