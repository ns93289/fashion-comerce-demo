import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/model_product.dart';

class ItemProduct extends StatelessWidget {
  final ModelProduct item;
  final Function()? onFavorite;

  const ItemProduct({super.key, required this.item, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    final ModelProduct(:productId, :favorite, :categoryName, :productImage, :productName, :productPrice) = item;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(colors: [colorProductStart, colorProductEnd], begin: AlignmentDirectional.bottomEnd, end: AlignmentDirectional.topStart),
      ),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
      width: 155.w,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(aspectRatio: 1, child: Image.asset(productImage, width: double.maxFinite, fit: BoxFit.cover)),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.h),
                child: Text(categoryName, style: bodyStyle(fontSize: 12.sp, color: colorTextLight)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(productName, style: bodyStyle(fontWeight: FontWeight.w500), maxLines: 1),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text("\$$productPrice", style: bodyStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 5.h),
                      decoration: BoxDecoration(color: colorBlack, borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(5.r))),
                      height: 30.sp,
                      width: 30.sp,
                      child: Icon(Icons.add, color: colorWhite),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => onFavorite?.call(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: favorite ? colorPrimary : colorWhite,
                boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 2, color: colorBlack.withAlpha(10))],
              ),
              margin: EdgeInsetsDirectional.only(top: 5.h, start: 5.w),
              height: 30.sp,
              width: 30.sp,
              padding: EdgeInsets.all(4.sp),
              child: Icon(favorite ? Icons.favorite : Icons.favorite_outline, color: favorite ? colorRed : colorBlack),
            ),
          ),
        ],
      ),
    );
  }
}
