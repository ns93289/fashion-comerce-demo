import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/order_details_service.dart';
import '../../data/repositories/order_details_repo_impl.dart';
import '../../domain/entities/order_details_entity.dart';
import '../../domain/repositories/order_details_repo.dart';
import '../bottomSheets/product_status_bottom_sheet.dart';

final orderDetailsRepoProvider = Provider.autoDispose<OrderDetailsRepo>((ref) => OrderDetailsRepoImpl());

final orderDetailsServiceProvider = StateNotifierProvider.autoDispose.family<OrderDetailsService, AsyncValue<OrderDetailsEntity?>, int>((ref, orderId) {
  final service = OrderDetailsService(ref.watch(orderDetailsRepoProvider));
  service.callOrderDetailsApi(orderId: orderId);
  return service;
});

final openProductStatusBSProvider = Provider.autoDispose.family<void, ({OrderDetailsEntity orderDetails, BuildContext context})>((ref, args) {
  showModalBottomSheet(
    context: args.context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return ProductStatusBottomSheet(orderNo: args.orderDetails.orderId.toString(), orderTime: args.orderDetails.orderDate);
    },
  );
});
