import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/tools.dart';
import '../../data/models/model_key_value.dart';

class ItemKeyValue extends StatelessWidget {
  final ModelKeyValue modelKeyValue;

  const ItemKeyValue({super.key, required this.modelKeyValue});

  @override
  Widget build(BuildContext context) {
    final ModelKeyValue(:keyTitle, :valueData, :valueColor, :setBold) = modelKeyValue;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Expanded(child: Text(keyTitle, style: bodyTextStyle(fontSize: 14.sp, fontWeight: setBold ? FontWeight.w600 : FontWeight.normal))),
          SizedBox(width: 10.w),
          Text(valueData, style: bodyTextStyle(fontSize: 14.sp, color: valueColor ?? colorText, fontWeight: setBold ? FontWeight.w600 : FontWeight.normal)),
        ],
      ),
    );
  }
}
