import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/theme.dart';

class EmptyRecordView extends StatelessWidget {
  final String? message;

  const EmptyRecordView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outlined, color: colorPrimary, size: 100.sp),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 5.sp, start: 40.w, end: 40.w),
            child: Text(message ?? "No Record Found", textAlign: TextAlign.center, style: bodyTextStyle(fontSize: 18.sp)),
          ),
        ],
      ),
    );
  }
}
