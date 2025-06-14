import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../domain/entities/home_category_entity.dart';
import '../../../../components/common_network_image.dart';

class ItemHomeCategory extends StatelessWidget {
  final HomeCategoryEntity item;

  const ItemHomeCategory({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 64.sp,
            width: 64.sp,
            decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(10.r)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CommonNetworkImage(image: item.image),
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: 5.h), child: Text(item.name, style: bodyTextStyle(fontSize: 12.sp))),
        ],
      ),
    );
  }
}
