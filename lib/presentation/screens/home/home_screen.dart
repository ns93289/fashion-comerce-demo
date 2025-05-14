import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/dataSources/local/hive_helper.dart';
import '../../../data/models/model_drawer.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/local/hive_constants.dart';
import '../../../domain/provider/home_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../cart/cart_screen.dart';
import '../serachProduct/search_product_screen.dart';
import 'pages/favorite/favorite_page.dart';
import 'pages/home/home_page.dart';
import 'pages/orders/orders_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: homeScaffoldKey,
        appBar: CommonAppBar(
          title: Text(language.appName),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              homeScaffoldKey.currentState?.openDrawer();
            },
            child: Icon(Icons.menu),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                openScreen(context, SearchProductScreen());
              },
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Icon(Icons.search_outlined)),
            ),
          ],
        ),
        drawer: _drawerList(),
        body: SafeArea(child: _buildHomeScreen()),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [HomePage(), Text("Category Page"), Text("Search Page"), OrdersPage(), FavoritePage()],
          ),
        ),
        _homeTabBar(),
      ],
    );
  }

  Widget _homeTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        boxShadow: [BoxShadow(color: colorBlack.withAlpha(10), blurRadius: 5, spreadRadius: 5, offset: Offset(0, 5))],
      ),
      height: 40.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home_outlined)),
              Tab(icon: Icon(Icons.person_outline)),
              Tab(icon: Icon(Icons.search, size: 0)),
              Tab(icon: Icon(Icons.history_outlined)),
              Tab(icon: Icon(Icons.favorite_outline)),
            ],
            dividerHeight: 0,
            indicatorPadding: EdgeInsets.zero,
            indicatorColor: Colors.transparent,
            tabAlignment: TabAlignment.fill,
            labelColor: colorPrimary,
            unselectedLabelColor: colorBlack,
          ),
          InkWell(
            onTap: () {
              openScreen(context, CartScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: colorBlack.withAlpha(10), blurRadius: 5, spreadRadius: 5)],
              ),
              padding: EdgeInsetsDirectional.all(5.sp),
              child: Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerList() {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, box, _) {
        final profilePicture = box.get(hiveProfilePicture, defaultValue: "");
        final fullName = box.get(hiveFullName, defaultValue: language.userName);
        final List<ModelDrawer> drawerList = ref.watch(drawerListProvider);

        return Container(
          color: colorWhite,
          width: 230.w,
          child: Column(
            children: [
              Container(
                color: colorPrimary.withAlpha(50),
                width: 1.sw,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: colorMainBackground, shape: BoxShape.circle),
                      height: 60.sp,
                      width: 60.sp,
                      margin: EdgeInsetsDirectional.only(top: 24.h),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: profilePicture.isNotEmpty ? Image.file(File(profilePicture), fit: BoxFit.cover) : Container(),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 10.h, start: 10.w, end: 10.w, bottom: 10.h),
                      child: Text(fullName, style: bodyTextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: drawerList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final ModelDrawer item = drawerList[index];
                    return GestureDetector(
                      onTap: () {
                        ref.read(openDrawerItemProvider((context: context, drawerItem: item)));
                      },
                      child: Container(
                        color: colorWhite,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsetsDirectional.only(start: 20.w, end: 10.w), child: Icon(item.icon)),
                            Expanded(child: Text(item.title, style: bodyTextStyle())),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
                              child: Icon(Icons.arrow_forward_ios, size: 15.sp, color: colorTextLight),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.h, color: colorDivider));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
