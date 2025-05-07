import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/order_history_model.dart';

final orderHistoryProvider = FutureProvider<List<OrderHistoryItem>>((ref) {
  return [
    OrderHistoryItem(
      orderId: 1,
      address: "101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India",
      productName: "Air Max Pre-Day, Air Office",
      orderQuantity: 2,
      orderAmount: 100,
      orderStatusMsg: "Arrived for shipping",
    ),
    OrderHistoryItem(
      orderId: 2,
      address: "101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India",
      productName: "Crater Impact",
      orderQuantity: 1,
      orderAmount: 100,
      orderStatusMsg: "Out for delivery",
    ),
  ];
});
