import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../domain/entities/category_entity.dart';
import '../../../../components/common_network_image.dart';

class ItemSubCategory extends StatelessWidget {
  final SubCategoryEntity modelSubCategory;

  const ItemSubCategory({super.key, required this.modelSubCategory});

  @override
  Widget build(BuildContext context) {
    final SubCategoryEntity(:subCategoryName, :tagLine, :subCategoryImage) = modelSubCategory;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(color: colorPrimary.withAlpha(50), borderRadius: BorderRadius.circular(10.r)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CommonNetworkImage(image: subCategoryImage, fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: 5.h),
        Text(subCategoryName, style: bodyTextStyle(fontSize: 14.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
        if (tagLine.isNotEmpty) Text(tagLine, style: bodyTextStyle(fontSize: 10.sp, color: colorRed)),
      ],
    );
  }
}
