import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/empty_record_view.dart';
import '../../provider/order_history_provider.dart';
import '../orderDetails/order_details_screen.dart';
import 'item_order_history.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.myOrders)), body: SafeArea(child: _buildOrderHistory()));
  }

  Widget _buildOrderHistory() {
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(orderHistoryProvider);

        return data.when(
          data: (orderHistoryList) {
            if (orderHistoryList.isEmpty) {
              return EmptyRecordView(message: language.emptyOrdersMsg);
            }
            return ListView.separated(
              itemCount: orderHistoryList.length,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
              itemBuilder: (context, index) {
                final orderHistoryItem = orderHistoryList[index];
                return ItemOrderHistory(
                  orderHistoryItem: orderHistoryItem,
                  onReviewPress: () {
                    openScreen(context, OrderDetailsScreen(orderId: orderHistoryList[index].orderId));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(thickness: 1.sp, color: colorDivider, height: 0));
              },
            );
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => Container(),
        );
      },
    );
  }
}
