import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../../core/utils/time_utils.dart';
import '../../../domain/entities/order_history_entity.dart';
import '../../../main.dart';
import '../../../core/constants/colors.dart';
import '../../components/common_network_image.dart';
import '../../components/custom_button.dart';

class ItemOrderHistory extends StatelessWidget {
  final OrderHistoryEntity orderHistoryItem;
  final Function()? onReviewPress;

  const ItemOrderHistory({super.key, required this.orderHistoryItem, this.onReviewPress});

  @override
  Widget build(BuildContext context) {
    final OrderHistoryEntity(:productName, :orderId, :orderedTime, :productImage) = orderHistoryItem;

    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          Container(
            width: 100.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: AspectRatio(aspectRatio: 1, child: CommonNetworkImage(image: productImage)),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName, maxLines: 2, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontSize: 12.sp)),
                  Spacer(),
                  Text("${language.orderId}: #$orderId", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorMainBackground),
                          alignment: Alignment.center,
                          height: 30.h,
                          child: Text(TimeUtils.getFormatedDate(orderedTime, returnFormat: "dd MMM,yyyy"), style: bodyTextStyle(fontSize: 14.sp), maxLines: 1),
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
