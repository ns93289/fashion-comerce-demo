import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/order_history_model.dart';

class ItemOrderHistory extends StatelessWidget {
  final OrderHistoryItem orderHistoryItem;

  const ItemOrderHistory({super.key, required this.orderHistoryItem});

  @override
  Widget build(BuildContext context) {
    final OrderHistoryItem(:productName, :orderAmount, :orderStatusMsg, :orderQuantity) = orderHistoryItem;

    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(colors: [colorProductStart, colorProductEnd], begin: AlignmentDirectional.bottomEnd, end: AlignmentDirectional.topStart),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName.replaceAll(RegExp(r'[\[\]]'), ""),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: bodyTextStyle(fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Text(orderStatusMsg, style: bodyTextStyle(fontSize: 12.sp, color: colorGreen)),
            Spacer(),
            Text("${language.items}: $orderQuantity", style: bodyTextStyle(fontSize: 12.sp)),
            Spacer(),
            Text("${language.total}: ${orderAmount.withCurrency}", style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
