import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../domain/entities/brands_entity.dart';
import '../../components/common_network_image.dart';

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
            child: CommonNetworkImage(image: brand.image),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5.w), child: Text(brand.name, style: bodyTextStyle(fontSize: 14.sp))),
        ],
      ),
    );
  }
}
