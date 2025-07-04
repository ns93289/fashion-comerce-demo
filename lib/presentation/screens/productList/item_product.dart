import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/string_utils.dart';
import '../../../core/utils/text_utils.dart';
import '../../../domain/entities/product_entity.dart';
import '../../components/common_network_image.dart';

class ItemProduct extends StatelessWidget {
  final ProductEntity item;
  final Function()? onFavorite;

  const ItemProduct({super.key, required this.item, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    final ProductEntity(
      :productId,
      :favorite,
      :categoryName,
      :productImage,
      :productName,
      :productPrice,
      :productDiscount,
      :productDiscountPrice,
      :averageRatings,
      :genderType,
      :discountType,
      :productStoke,
      :isForMale,
      :isForFemale,
      :isForKids,
    ) = item;
    return Container(
      margin: EdgeInsetsDirectional.only(end: 15.w),
      width: 160.w,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    DefaultData.localMode
                        ? Image.asset(productImage, width: double.maxFinite, height: double.maxFinite, fit: BoxFit.cover)
                        : CommonNetworkImage(image: productImage),
                    if (discountType != 0)
                      Container(
                        color: colorDiscount,
                        margin: EdgeInsetsDirectional.only(start: 5.w, top: 5.h),
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: Text(
                          "${language.save} ${TextUtils.getDiscountString(discountType, productDiscount)}",
                          style: bodyTextStyle(fontSize: 10.sp, color: colorWhite),
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Container(
                        color: colorDiscount,
                        margin: EdgeInsetsDirectional.only(start: 5.w, bottom: 5.h),
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: Text("$productStoke ${language.left}", style: bodyTextStyle(fontSize: 10.sp, color: colorWhite)),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: GestureDetector(
                        onTap: () => onFavorite?.call(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: favorite ? colorPrimary : colorWhite,
                            boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 2, color: colorBlack.withAlpha(10))],
                          ),
                          margin: EdgeInsetsDirectional.only(top: 5.h, end: 5.w),
                          height: 25.sp,
                          width: 25.sp,
                          padding: EdgeInsets.all(4.sp),
                          child: Icon(favorite ? Icons.favorite : Icons.favorite_outline, color: favorite ? colorRed : colorBlack, size: 16.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                child: Text(productName, style: bodyTextStyle(fontSize: 14.sp), maxLines: 1),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 1.h),
                    margin: EdgeInsetsDirectional.only(start: 2.w, end: 10.w),
                    decoration: BoxDecoration(color: colorCategoryBackground, borderRadius: BorderRadius.circular(5.r)),
                    child: Text(
                      StringUtils.getGenderTitle(isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids),
                      style: bodyTextStyle(fontSize: 12.sp),
                    ),
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
              SizedBox(height: 10.h),
              Expanded(
                child: Row(
                  children: [
                    Padding(padding: EdgeInsetsDirectional.only(start: 2.w, end: 5.w), child: Text("\$$productPrice", style: bodyTextStyle(fontSize: 14.sp))),
                    if (discountType > 0)
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 5.w),
                        child: Text(
                          "\$$productDiscountPrice",
                          style: bodyTextStyle(fontSize: 10.sp, decoration: TextDecoration.lineThrough, color: colorTextLight),
                        ),
                      ),
                    Icon(Icons.star, color: Colors.amber, size: 12.sp),
                    Text(averageRatings.toString(), style: bodyTextStyle(fontSize: 10.sp)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
