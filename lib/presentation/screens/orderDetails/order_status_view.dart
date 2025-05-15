import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';

class OrderStatusView extends StatelessWidget {
  final int orderStatus;
  final String deliveryTime;
  final String shippedTime;
  final String packedTime;
  final String orderTime;
  final String cancelledBy;

  const OrderStatusView({
    super.key,
    required this.orderStatus,
    required this.deliveryTime,
    required this.shippedTime,
    required this.packedTime,
    required this.orderTime,
    this.cancelledBy = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(orderStatus > 0 ? Icons.check_circle : Icons.circle, size: 18.sp, color: orderStatus > 0 ? colorGreen : colorTextLight),
                Container(color: orderStatus > 0 ? colorGreen : colorOrderStatusProgress, width: 3.w, height: 50.h),
              ],
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.ordered,
                    style: bodyTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: orderStatus > 0 ? colorText : colorTextLight),
                  ),
                  SizedBox(height: 2.5.h),
                  Text(orderTime, style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight)),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(orderStatus > 1 ? Icons.check_circle : Icons.circle, size: 18.sp, color: orderStatus > 1 ? colorGreen : colorTextLight),
                Container(color: orderStatus > 1 ? colorGreen : colorOrderStatusProgress, width: 3.w, height: 50.h),
              ],
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.packed,
                    style: bodyTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: orderStatus > 1 ? colorText : colorTextLight),
                  ),
                  if (orderStatus > 1) SizedBox(height: 2.5.h),
                  if (orderStatus > 1) Text(packedTime, style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight)),
                ],
              ),
            ),
          ],
        ),
        if (orderStatus == 3)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [Icon(Icons.cancel_rounded, size: 18.sp, color: colorRed), Container(color: colorOrderStatusProgress, width: 3.w, height: 50.h)],
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.cancelled,
                      style: bodyTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: orderStatus > 0 ? colorText : colorTextLight),
                    ),
                    SizedBox(height: 2.5.h),
                    Text("${language.orderCancelBy} $cancelledBy", style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight)),
                  ],
                ),
              ),
            ],
          ),
        if (orderStatus != 3)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(orderStatus > 3 ? Icons.check_circle : Icons.circle, size: 18.sp, color: orderStatus > 3 ? colorGreen : colorTextLight),
                  Container(color: orderStatus > 3 ? colorGreen : colorOrderStatusProgress, width: 3.w, height: 50.h),
                ],
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.shipped,
                      style: bodyTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: orderStatus > 3 ? colorText : colorTextLight),
                    ),
                    SizedBox(height: 2.5.h),
                    Text(shippedTime, style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight)),
                  ],
                ),
              ),
            ],
          ),
        if (orderStatus != 3)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(orderStatus > 4 ? Icons.check_circle : Icons.circle, size: 18.sp, color: orderStatus > 4 ? colorGreen : colorTextLight),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.delivery,
                      style: bodyTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: orderStatus > 4 ? colorText : colorTextLight),
                    ),
                    SizedBox(height: 2.5.h),
                    Text(
                      orderStatus <= 5 ? "${language.expectedBy} $deliveryTime" : "${language.delivered} $deliveryTime",
                      style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
