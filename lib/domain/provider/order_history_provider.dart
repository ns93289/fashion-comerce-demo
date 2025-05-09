import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/local/hive_helper.dart';
import '../../data/models/order_history_model.dart';

final orderHistoryProvider = FutureProvider.autoDispose<List<OrderHistoryItem>>((ref) {
  List<OrderHistoryItem> orderList = getOrderHistoryDataFromOrderBox();

  return orderList;
});
