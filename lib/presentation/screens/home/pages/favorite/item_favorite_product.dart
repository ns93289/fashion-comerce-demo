import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/model_product.dart';
import '../../../../../main.dart';

class ItemFavoriteProduct extends StatelessWidget {
  final ModelProductItem item;
  final Function()? onUnfavorite;

  const ItemFavoriteProduct({super.key, required this.item, this.onUnfavorite});

  @override
  Widget build(BuildContext context) {
    final ModelProductItem(:id, :favorite, :category, :name, :price) = item;

    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 20.h),
      height: 90.sp,
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
            child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/images/shoes4.png")),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontWeight: FontWeight.w500)),
                Text(category, style: bodyTextStyle(fontSize: 14.sp)),
                Spacer(),
                Row(
                  children: [
                    Expanded(child: Text("${language.price}: ${price.withCurrency}", style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp))),
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
