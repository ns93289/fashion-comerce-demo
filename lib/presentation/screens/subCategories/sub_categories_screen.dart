import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../data/models/model_category.dart';
import '../../provider/category_provider.dart';
import '../../components/common_app_bar.dart';

class SubCategoriesScreen extends StatefulWidget {
  final int genderType;
  final int categoryId;
  final int selectedSubCategoryId;
  final String selectedSubCategoryName;

  const SubCategoriesScreen({
    super.key,
    required this.genderType,
    required this.categoryId,
    required this.selectedSubCategoryId,
    required this.selectedSubCategoryName,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        List<ModelSubCategory> subCategories = ref.watch(genderWiseSubCategoryProvider((genderType: widget.genderType, categoryId: widget.categoryId)));
        int selectedIndex = subCategories.indexWhere((element) => element.subCategoryId == widget.selectedSubCategoryId);

        return DefaultTabController(
          length: subCategories.length,
          initialIndex: selectedIndex,
          child: Scaffold(appBar: CommonAppBar(title: Text(widget.selectedSubCategoryName)), body: _genderWiseSubCategories(subCategories)),
        );
      },
    );
  }

  Widget _genderWiseSubCategories(List<ModelSubCategory> subCategories) {
    return Consumer(
      builder: (context, ref, _) {
        return Container(
          decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 0, offset: Offset(0, 0))]),
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: TabBar(
            tabs: subCategories.map((e) => Tab(text: e.subCategoryName, height: 25.h)).toList(),
            labelStyle: bodyStyle(fontWeight: FontWeight.w500),
            unselectedLabelColor: colorTextLight,
            labelColor: colorPrimary,
            indicatorColor: colorPrimary,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
          ),
        );
      },
    );
  }
}
