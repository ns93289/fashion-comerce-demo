import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../../main.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/order_history_model.dart';
import '../../../../components/custom_button.dart';

class ItemOrderHistory extends StatelessWidget {
  final OrderHistoryItem orderHistoryItem;
  final Function()? onReviewPress;

  const ItemOrderHistory({super.key, required this.orderHistoryItem, this.onReviewPress});

  @override
  Widget build(BuildContext context) {
    final OrderHistoryItem(:productName, :orderNo, :orderedTime, :orderQuantity) = orderHistoryItem;

    return Row(
      children: [
        SizedBox(
          width: 121.w,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: colorProductStart,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [BoxShadow(blurRadius: 10, offset: Offset(0, 5), color: colorShadow)],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName.replaceAll(RegExp(r'[\[\]]'), ""), maxLines: 2, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontSize: 12.sp)),
                SizedBox(height: 10.h),
                Text("${language.orderId}: $orderNo", style: bodyStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                Text(orderedTime, style: bodyStyle(fontSize: 14.sp)),
                CustomButton(
                  title: language.review,
                  borderedButton: true,
                  width: 1.sw,
                  textColor: colorPrimary,
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  onPress: () {
                    onReviewPress?.call();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
