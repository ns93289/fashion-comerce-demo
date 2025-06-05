import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../main.dart';
import '../../../data/models/model_product.dart';

class ItemCartData extends StatelessWidget {
  final ModelProduct item;

  const ItemCartData({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ModelProduct(
      :productName,
      :productImage,
      :productId,
      :productPrice,
      :selectedSize,
      :selectedQuantity,
      :categoryName,
      :selectedColor,
      :productDiscount,
    ) = item;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: colorProductEnd,
          width: 80.sp,
          margin: EdgeInsetsDirectional.only(end: 15.w),
          child: AspectRatio(aspectRatio: 1, child: Image.asset(productImage, fit: BoxFit.cover)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productName, maxLines: 1, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 1.h),
                    margin: EdgeInsetsDirectional.only(end: 10.w),
                    decoration: BoxDecoration(color: colorCategoryBackground, borderRadius: BorderRadius.circular(5.r)),
                    child: Text("Men", style: bodyTextStyle(fontSize: 12.sp)),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 1.h),
                      margin: EdgeInsetsDirectional.only(end: 10.w),
                      decoration: BoxDecoration(color: colorCategoryBackground, borderRadius: BorderRadius.circular(5.r)),
                      child: Text(categoryName, style: bodyTextStyle(fontSize: 12.sp), maxLines: 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "${language.size}: ", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        TextSpan(text: selectedSize.toString(), style: bodyTextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "${language.colors}: ", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        TextSpan(text: selectedColor.toString(), style: bodyTextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(productPrice.withCurrency, style: bodyTextStyle(fontSize: 14.sp)),
                  SizedBox(width: 10.w),
                  Text(productDiscount.withCurrency, style: bodyTextStyle(fontSize: 12.sp, decoration: TextDecoration.lineThrough, color: colorTextLight)),
                  Spacer(),
                  Icon(Icons.remove, size: 15.sp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(selectedQuantity.toString(), style: bodyTextStyle(fontSize: 14.sp)),
                  ),
                  Icon(Icons.add, size: 15.sp),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
