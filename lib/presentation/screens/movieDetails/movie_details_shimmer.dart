import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';

class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: colorShimmerHighlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(color: colorPrimary, height: 278.sp, width: double.maxFinite),
          Container(margin: EdgeInsetsDirectional.only(start: 10.w, end: 5.w, top: 5.h, bottom: 5.h), color: colorWhite, height: 16.sp, width: 200.w),
          Container(margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), color: colorWhite, height: 14.sp, width: 100.w),
          Container(margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), color: colorWhite, height: 14.sp, width: double.maxFinite),
          Container(margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), color: colorWhite, height: 14.sp, width: double.maxFinite),
          Container(margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), color: colorWhite, height: 14.sp, width: double.maxFinite),
          Container(margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), color: colorWhite, height: 14.sp, width: double.maxFinite),
        ],
      ),
    );
  }
}
