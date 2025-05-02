import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../utils/tools.dart';

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
          Padding(padding: EdgeInsetsDirectional.only(top: 5.sp), child: Text(message ?? "No Record Found", style: bodyTextStyle(fontSize: 18.sp))),
        ],
      ),
    );
  }
}
