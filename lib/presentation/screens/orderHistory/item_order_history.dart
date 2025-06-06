import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../../main.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../data/models/order_history_model.dart';
import '../../components/custom_button.dart';

class ItemOrderHistory extends StatelessWidget {
  final OrderHistoryItem orderHistoryItem;
  final Function()? onReviewPress;

  const ItemOrderHistory({super.key, required this.orderHistoryItem, this.onReviewPress});

  @override
  Widget build(BuildContext context) {
    final OrderHistoryItem(:productName, :orderNo, :orderedTime, :orderQuantity) = orderHistoryItem;

    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          SizedBox(width: 100.w, child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/images/classic_slip_on.png", fit: BoxFit.cover))),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName.replaceAll(RegExp(r'[\[\]]'), ""), maxLines: 2, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontSize: 12.sp)),
                  Spacer(),
                  Text("${language.orderId}: $orderNo", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorMainBackground),
                          alignment: Alignment.center,
                          height: 30.h,
                          child: Text(getFormatedDate(orderedTime, returnFormat: "dd MMM,yyyy"), style: bodyTextStyle(fontSize: 14.sp), maxLines: 1),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomButton(
                          title: language.review,
                          borderedButton: true,
                          width: 1.sw,
                          textColor: colorPrimary,
                          borderColor: colorPrimary,
                          fontSize: 14.sp,
                          height: 30.h,
                          onPress: () {
                            onReviewPress?.call();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
