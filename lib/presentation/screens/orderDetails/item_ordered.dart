import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../main.dart';
import '../../../core/utils/tools.dart';
import '../../../data/models/model_product.dart';

class ItemOrdered extends StatelessWidget {
  final ModelProduct orderedProducts;

  const ItemOrdered({super.key, required this.orderedProducts});

  @override
  Widget build(BuildContext context) {
    final ModelProduct(:productName, :productPrice, :sellerName, :selectedQuantity, :selectedSize, :selectedColor, :productImage) = orderedProducts;

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
                      "$productName, $selectedSize'' x $selectedQuantity",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: bodyStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.h),
                    Text(selectedColor, style: bodyStyle(fontSize: 14.sp)),
                  ],
                ),
              ),
              Container(
                width: 90.sp,
                margin: EdgeInsetsDirectional.only(start: 10.w),
                child: AspectRatio(aspectRatio: 1, child: Image.asset(productImage, fit: BoxFit.cover)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 5.h),
            child: Text("${language.seller}: $sellerName", style: bodyStyle(fontSize: 14.sp, color: colorTextLight)),
          ),
        ],
      ),
    );
  }
}
