import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../main.dart';
import 'category_list_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(length: 3, child: Column(children: [_genderTabs(), Expanded(child: _genderWiseCategoryList())]));
  }

  Widget _genderTabs() {
    return Container(
      decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 0, offset: Offset(0, 0))]),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: TabBar(
        tabs: [Tab(text: language.men, height: 25.h), Tab(text: language.women, height: 25.h), Tab(text: language.kids, height: 25.h)],
        labelStyle: bodyTextStyle(fontWeight: FontWeight.w500),
        unselectedLabelColor: colorTextLight,
        labelColor: colorPrimary,
        indicatorColor: colorPrimary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _genderWiseCategoryList() {
    return TabBarView(
      children: [
        CategoryListPage(genderType: GenderTypes.male),
        CategoryListPage(genderType: GenderTypes.female),
        CategoryListPage(genderType: GenderTypes.kids),
      ],
    );
  }
}
