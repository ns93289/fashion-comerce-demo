import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../components/common_circle_progress_bar.dart';
import '../../../../components/empty_record_view.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../domain/entities/category_entity.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/navigation_provider.dart';
import '../../../subCategories/sub_categories_screen.dart';
import 'item_sub_category.dart';

class CategoryListPage extends StatefulWidget {
  final int genderType;

  const CategoryListPage({super.key, required this.genderType});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 150.w, child: _categoryList()), Expanded(child: _subCategoryList())]);
  }

  Widget _categoryList() {
    return Consumer(
      builder: (context, ref, child) {
        final apiResponse = ref.watch(categoryServiceProvider);
        return apiResponse.when(
          data: (data) {
            if (data == null) {
              return CommonCircleProgressBar();
            }
            int selectedCategoryId = ref.watch(selectedCategoryProvider(widget.genderType));
            List<CategoryEntity> categories = data as List<CategoryEntity>;
            categories =
                categories.where((element) {
                  if (widget.genderType == GenderTypes.male) {
                    return element.isForMale;
                  } else if (widget.genderType == GenderTypes.female) {
                    return element.isForFemale;
                  } else {
                    return element.isForKids;
                  }
                }).toList();

            return Container(
              color: colorMainBackground,
              height: 1.sh,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  CategoryEntity category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedCategoryProvider(widget.genderType).notifier).state = category.categoryId;
                    },
                    child: Container(
                      decoration: BoxDecoration(color: selectedCategoryId == category.categoryId ? colorPrimary.withAlpha(50) : colorMainBackground),
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                      child: Text(category.categoryName, style: bodyTextStyle()),
                    ),
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) {
            debugPrintStack(stackTrace: stackTrace);
            return Container();
          },
          loading: () => CommonCircleProgressBar(),
        );
      },
    );
  }

  Widget _subCategoryList() {
    return Consumer(
      builder: (context, ref, child) {
        int selectedCategoryId = ref.watch(selectedCategoryProvider(widget.genderType));
        if (selectedCategoryId == 0) {
          return Container();
        }
        final apiResponse = ref.watch(
          subCategoryServiceProvider((
            categoryId: selectedCategoryId,
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
            return GridView.builder(
              itemCount: subCategories.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.64, crossAxisSpacing: 20.w, mainAxisSpacing: 10.h),
              itemBuilder: (context, index) {
                final SubCategoryEntity modelSubCategory = subCategories[index];

                return GestureDetector(
                  onTap: () {
                    ref
                        .read(navigationServiceProvider)
                        .navigateTo(
                          SubCategoriesScreen(
                            genderType: widget.genderType,
                            categoryId: selectedCategoryId,
                            selectedSubCategoryId: modelSubCategory.subCategoryId,
                            selectedSubCategoryName: modelSubCategory.subCategoryName,
                          ),
                        );
                  },
                  child: ItemSubCategory(modelSubCategory: modelSubCategory),
                );
              },
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

  @override
  bool get wantKeepAlive => true;
}
