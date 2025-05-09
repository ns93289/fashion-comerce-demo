import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../components/empty_record_view.dart';
import '../../../../../domain/provider/order_history_provider.dart';
import '../../../orderDetails/order_details_screen.dart';
import 'item_order_history.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(orderHistoryProvider);

        return data.when(
          data: (data) {
            return ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    openScreen(context, OrderDetailsScreen(orderId: data[index].orderId));
                  },
                  child: ItemOrderHistory(orderHistoryItem: data[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(thickness: 1.sp, color: colorMainBackground, height: 0));
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
