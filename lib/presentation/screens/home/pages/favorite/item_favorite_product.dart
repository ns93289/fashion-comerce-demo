import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/extensions.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../domain/entities/product_entity.dart';
import '../../../../../main.dart';

class ItemFavoriteProduct extends StatelessWidget {
  final ProductEntity item;
  final Function()? onUnfavorite;

  const ItemFavoriteProduct({super.key, required this.item, this.onUnfavorite});

  @override
  Widget build(BuildContext context) {
    final ProductEntity(:productId, :favorite, :productImage, :categoryName, :productName, :productPrice) = item;

    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 20.h),
      height: 90.sp,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(colors: [colorProductStart, colorProductEnd], begin: AlignmentDirectional.bottomEnd, end: AlignmentDirectional.topStart),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90.sp,
            margin: EdgeInsetsDirectional.only(end: 10.w),
            child: AspectRatio(aspectRatio: 1, child: Image.asset(productImage, fit: BoxFit.cover)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(productName, maxLines: 2, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontWeight: FontWeight.w500)),
                Text(categoryName, style: bodyTextStyle(fontSize: 14.sp)),
                Spacer(),
                Row(
                  children: [
                    Expanded(child: Text("${language.price}: ${productPrice.withCurrency}", style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp))),
                    GestureDetector(
                      onTap: () => onUnfavorite?.call(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: favorite ? colorPrimary : colorWhite,
                          boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 2, color: colorBlack.withAlpha(10))],
                        ),
                        margin: EdgeInsetsDirectional.only(end: 10.w),
                        height: 20.sp,
                        width: 20.sp,
                        padding: EdgeInsets.all(4.sp),
                        child: Icon(favorite ? Icons.favorite : Icons.favorite_outline, color: favorite ? colorRed : colorBlack, size: 12.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
