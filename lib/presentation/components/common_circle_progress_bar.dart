import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class CommonCircleProgressBar extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? stroke;

  const CommonCircleProgressBar({super.key, this.size, this.color, this.stroke});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 40.sp,
      height: size ?? 40.sp,
      child: Center(child: CircularProgressIndicator(color: color ?? colorPrimary, strokeWidth: stroke ?? 3.sp)),
    );
  }
}
