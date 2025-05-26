import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../data/models/modle_preference.dart';

class ItemLanguage extends StatelessWidget {
  final ModelLanguage modelLanguage;
  final bool selected;

  const ItemLanguage({super.key, required this.modelLanguage, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? colorPrimary.withAlpha(50) : colorWhite,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: selected ? colorPrimary : colorDivider),
      ),
      margin: EdgeInsetsDirectional.only(bottom: 20.h),
      padding: EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Row(children: [Text(modelLanguage.title, style: bodyStyle()), Expanded(child: Text(" - ${modelLanguage.language}", style: bodyStyle()))]),
    );
  }
}
