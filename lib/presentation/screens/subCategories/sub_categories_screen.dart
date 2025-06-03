import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/category_entity.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../components/empty_record_view.dart';
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
        final apiResponse = ref.watch(subCategoryServiceProvider(widget.categoryId));

        return apiResponse.when(
          data: (data) {
            if (data == null) {
              return CommonCircleProgressBar();
            }
            List<SubCategoryEntity> subCategories = data as List<SubCategoryEntity>;
            int selectedIndex = subCategories.indexWhere((element) => element.subCategoryId == widget.selectedSubCategoryId);

            return DefaultTabController(
              length: subCategories.length,
              initialIndex: selectedIndex,
              child: Scaffold(appBar: CommonAppBar(title: Text(widget.selectedSubCategoryName)), body: _genderWiseSubCategories(subCategories)),
            );
          },
          error: (error, stackTrace) {
            debugPrintStack(stackTrace: stackTrace);
            return EmptyRecordView(message: error.toString());
          },
          loading: () => CommonCircleProgressBar(),
        );
      },
    );
  }

  Widget _genderWiseSubCategories(List<SubCategoryEntity> subCategories) {
    return Consumer(
      builder: (context, ref, _) {
        return Container(
          decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 0, offset: Offset(0, 0))]),
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: TabBar(
            tabs: subCategories.map((e) => Tab(text: e.subCategoryName, height: 25.h)).toList(),
            labelStyle: bodyTextStyle(fontWeight: FontWeight.w500),
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
