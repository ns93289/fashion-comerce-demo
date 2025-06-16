import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../domain/entities/category_entity.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../components/empty_record_view.dart';
import '../../provider/category_provider.dart';
import '../../components/common_app_bar.dart';
import 'subcategory_page.dart';

class SubCategoriesScreen extends StatefulWidget {
  final int genderType;
  final int categoryId;
  final int selectedSubCategoryId;
  final String selectedSubCategoryName;
  final bool isForMale;
  final bool isForFemale;
  final bool isForKids;

  const SubCategoriesScreen({
    super.key,
    required this.genderType,
    required this.categoryId,
    required this.selectedSubCategoryId,
    required this.selectedSubCategoryName,
    required this.isForMale,
    required this.isForFemale,
    required this.isForKids,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.selectedSubCategoryName)), body: SafeArea(child: _buildSubCategories()));
  }

  Widget _buildSubCategories() {
    return Consumer(
      builder: (context, ref, _) {
        final apiResponse = ref.watch(
          subCategoryServiceProvider((
            categoryId: widget.categoryId,
            isForMale: widget.genderType == GenderTypes.male,
            isForFemale: widget.genderType == GenderTypes.female,
            isForKids: widget.genderType == GenderTypes.kids,
          )),
        );

        return apiResponse.when(
          data: (data) {
            if (data == null) {
              return CommonCircleProgressBar();
            }
            List<SubCategoryEntity> subCategories = data as List<SubCategoryEntity>;
            int selectedIndex = subCategories.indexWhere((element) => element.subCategoryId == widget.selectedSubCategoryId);

            return DefaultTabController(length: subCategories.length, initialIndex: selectedIndex, child: _genderWiseSubCategories(subCategories));
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
        return Column(
          children: [
            Container(
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
            ),
            Expanded(
              child: TabBarView(
                children:
                    subCategories.map((e) {
                      return SubcategoryPage(
                        isForMale: widget.isForMale,
                        isForFemale: widget.isForFemale,
                        isForKids: widget.isForKids,
                        selectedSubCategoryId: e.subCategoryId,
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
