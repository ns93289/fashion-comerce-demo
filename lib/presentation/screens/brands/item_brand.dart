import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../data/dataSources/remote/api_constant.dart';
import '../../../domain/entities/brands_entity.dart';

class ItemBrand extends StatelessWidget {
  final BrandsEntity brand;

  const ItemBrand({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorBorder, borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsetsDirectional.only(end: 15.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: colorBlack, borderRadius: BorderRadius.circular(10.r)),
            height: 40.sp,
            width: 40.sp,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
              imageUrl: "${BaseUrl.url}${brand.image}",
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
              fadeInDuration: Duration.zero,
              placeholderFadeInDuration: Duration.zero,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5.w), child: Text(brand.name, style: bodyTextStyle(fontSize: 14.sp))),
        ],
      ),
    );
  }
}
