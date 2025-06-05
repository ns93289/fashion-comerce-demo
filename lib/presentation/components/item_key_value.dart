import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/theme.dart';
import '../../data/models/model_key_value.dart';

class ItemKeyValue extends StatelessWidget {
  final ModelKeyValue modelKeyValue;

  const ItemKeyValue({super.key, required this.modelKeyValue});

  @override
  Widget build(BuildContext context) {
    final ModelKeyValue(:keyTitle, :valueData, :valueColor, :setBold, :setDivider) = modelKeyValue;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          if (setDivider) Padding(padding: EdgeInsets.only(top: 5.h, bottom: 10.h), child: Divider(color: colorDivider, thickness: 1.sp, height: 0)),
          Row(
            children: [
              Expanded(child: Text(keyTitle, style: bodyTextStyle(fontSize: 14.sp, fontWeight: setBold ? FontWeight.bold : FontWeight.w600))),
              SizedBox(width: 10.w),
              Text(valueData, style: bodyTextStyle(fontSize: 14.sp, color: valueColor ?? colorText, fontWeight: setBold ? FontWeight.w600 : FontWeight.normal)),
            ],
          ),
        ],
      ),
    );
  }
}
