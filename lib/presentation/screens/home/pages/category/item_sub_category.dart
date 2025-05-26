import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/model_category.dart';

class ItemSubCategory extends StatelessWidget {
  final ModelSubCategory modelSubCategory;

  const ItemSubCategory({super.key, required this.modelSubCategory});

  @override
  Widget build(BuildContext context) {
    final ModelSubCategory(:subCategoryName, :tagline) = modelSubCategory;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(decoration: BoxDecoration(color: colorPrimary.withAlpha(50), borderRadius: BorderRadius.circular(10.r))),
        ),
        SizedBox(height: 5.h),
        Text(subCategoryName, style: bodyStyle(fontSize: 14.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
        if (tagline.isNotEmpty) Text(tagline, style: bodyStyle(fontSize: 10.sp, color: colorRed)),
      ],
    );
  }
}
