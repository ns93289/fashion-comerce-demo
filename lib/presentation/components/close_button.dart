import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/custom_icons.dart';
import '../../main.dart';

class CommonCloseButton extends StatelessWidget {
  const CommonCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigationService.goBack(),
      child: Container(
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsetsDirectional.only(bottom: 5.h, end: 10.w),
        decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(5.r)),
        child: Icon(CustomIcons.cancel),
      ),
    );
  }
}
