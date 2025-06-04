import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';

class ItemHomeCategory extends StatelessWidget {
  const ItemHomeCategory({super.key});

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
            child: Image.asset("assets/images/category_image.png", fit: BoxFit.cover),
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: 5.h), child: Text("Men", style: bodyTextStyle(fontSize: 12.sp))),
        ],
      ),
    );
  }
}
