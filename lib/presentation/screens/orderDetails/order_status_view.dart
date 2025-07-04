import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/time_utils.dart';
import "../../components/custom_button.dart";
import '../../../core/constants/custom_icons.dart';
import '../../../core/constants/theme.dart';
import '../../../main.dart';

class OrderStatusView extends StatelessWidget {
  final int orderStatus;
  final String orderTime;
  final String cancelledBy;
  final Function()? onViewStatusClick;
  final Function()? onCancelClick;
  final Function()? onExchangeClick;
  final Function()? onReturnClick;

  const OrderStatusView({
    super.key,
    required this.orderStatus,
    this.cancelledBy = "",
    this.onViewStatusClick,
    this.onCancelClick,
    this.onExchangeClick,
    this.onReturnClick,
    required this.orderTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(CustomIcons.clock, color: Colors.amber, size: 20.sp),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(language.orderShipped, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 5.h),
                    Text(TimeUtils.getFormatedDate(orderTime), style: bodyTextStyle(fontSize: 12.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Text(language.exchangeMsg, style: bodyTextStyle(fontSize: 12.sp)),
        CustomButton(
          title: language.viewFullDetails,
          height: 30.h,
          width: 1.sw,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          margin: EdgeInsetsDirectional.only(top: 15.h),
          onPress: () => onViewStatusClick?.call(),
        ),
        CustomButton(
          title: language.cancel,
          height: 30.h,
          width: 1.sw,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          borderedButton: true,
          margin: EdgeInsetsDirectional.only(top: 15.h),
        ),
        /*SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: CustomButton(title: language.exchange, height: 30.h, width: 1.sw, fontSize: 14.sp, fontWeight: FontWeight.w500, borderedButton: true),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: CustomButton(title: language.txtReturn, height: 30.h, width: 1.sw, fontSize: 14.sp, fontWeight: FontWeight.w500, borderedButton: true),
            ),
          ],
        ),*/
      ],
    );
  }
}
