import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../domain/entities/cart_preview_entity.dart';
import '../../../main.dart';
import '../../components/common_network_image.dart';

class ItemCartData extends StatelessWidget {
  final CartProductEntity item;
  final bool allowEdit;
  final Function()? onAdd;
  final Function()? onRemove;

  const ItemCartData({super.key, required this.item, this.allowEdit = true, this.onAdd, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final CartProductEntity(:productName, :imageUrl, :productId, :finalPrice, :size, :quantity, :subCategory, :color, :price, :discountType) = item;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: colorProductEnd,
          width: 80.sp,
          margin: EdgeInsetsDirectional.only(end: 15.w),
          child: AspectRatio(aspectRatio: 1, child: CommonNetworkImage(image: imageUrl)),
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
                      child: Text(subCategory, style: bodyTextStyle(fontSize: 12.sp), maxLines: 1),
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
                        TextSpan(text: size, style: bodyTextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "${language.colors}: ", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        TextSpan(text: color, style: bodyTextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(finalPrice.withCurrency, style: bodyTextStyle(fontSize: 14.sp)),
                  SizedBox(width: 10.w),
                  if (discountType > 0)
                    Text(price.withCurrency, style: bodyTextStyle(fontSize: 12.sp, decoration: TextDecoration.lineThrough, color: colorTextLight)),
                  Spacer(),
                  if (allowEdit)
                    Row(
                      children: [
                        GestureDetector(onTap: () => onRemove?.call(), child: Icon(Icons.remove, size: 15.sp)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Text(quantity.toString(), style: bodyTextStyle(fontSize: 14.sp))),
                        GestureDetector(onTap: () => onAdd?.call(), child: Icon(Icons.add, size: 15.sp)),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
