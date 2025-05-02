import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';

class MovieListShimmer extends StatelessWidget {
  const MovieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: colorShimmerHighlight,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(16, (index) {
          return Row(
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(color: colorWhite, height: 200.h),
                      Container(
                        color: colorWhite,
                        height: 16.sp,
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.h),
                      ),
                      Container(color: colorWhite, height: 16.sp, width: 100.w, margin: EdgeInsetsDirectional.only(start: 10.w, bottom: 2.h)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(color: colorWhite, height: 200.h),
                      Container(
                        color: colorWhite,
                        height: 16.sp,
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.h),
                      ),
                      Container(color: colorWhite, height: 16.sp, width: 100.w, margin: EdgeInsetsDirectional.only(start: 10.w, bottom: 2.h)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
            ],
          );
        }),
      ),
    );
  }
}
