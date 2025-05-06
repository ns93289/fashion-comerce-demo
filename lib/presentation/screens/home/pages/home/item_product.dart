import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/model_product.dart';

class ItemProduct extends StatelessWidget {
  final ModelProductItem item;

  const ItemProduct({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ModelProductItem(:id, :favorite, :category, :name, :price) = item;
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
              Expanded(child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/images/shoes3.webp", width: double.maxFinite, fit: BoxFit.cover))),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.h),
                child: Text(category, style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight)),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Text(name, style: bodyTextStyle(fontWeight: FontWeight.w500))),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text("\$$price", style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
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
            ],
          ),
          Container(
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
        ],
      ),
    );
  }
}
