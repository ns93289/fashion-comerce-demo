import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:fashion_comerce_demo/presentation/components/empty_record_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/provider/order_history_provider.dart';
import 'item_ordered_product.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
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
                return ItemOrderedProduct(orderHistoryItem: data[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Divider(thickness: 1.sp, color: colorMainBackground, height: 0),
                );
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
