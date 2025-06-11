import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../data/models/modle_preference.dart';
import '../../components/custom_radio.dart';

class ItemLanguage extends StatelessWidget {
  final ModelLanguage modelLanguage;
  final bool selected;

  const ItemLanguage({super.key, required this.modelLanguage, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Text(modelLanguage.title, style: bodyTextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(" - ${modelLanguage.language}", style: bodyTextStyle(fontSize: 14.sp))),
          CustomRadio(selected: selected),
        ],
      ),
    );
  }
}
