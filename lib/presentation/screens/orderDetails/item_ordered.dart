import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/tools.dart';
import '../../../data/models/model_order_details.dart';

class ItemOrdered extends StatelessWidget {
  final OrderedProducts orderedProducts;

  const ItemOrdered({super.key, required this.orderedProducts});

  @override
  Widget build(BuildContext context) {
    final OrderedProducts(:productName, :productPrice, :productColor, :productSize, :productQuantity, :sellerName) = orderedProducts;

    return Container(
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$productName, $productSize'' x $productQuantity",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: bodyTextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.h),
                    Text(productColor, style: bodyTextStyle(fontSize: 14.sp)),
                  ],
                ),
              ),
              Container(
                width: 90.sp,
                margin: EdgeInsetsDirectional.only(start: 10.w),
                child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/images/shoes4.png")),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 5.h),
            child: Text("${language.seller}: $sellerName", style: bodyTextStyle(fontSize: 14.sp, color: colorTextLight)),
          ),
        ],
      ),
    );
  }
}
