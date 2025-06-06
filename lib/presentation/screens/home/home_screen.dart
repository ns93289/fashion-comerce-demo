import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../cart/cart_screen.dart';
import '../serachProduct/search_product_screen.dart';
import 'pages/account/account_page.dart';
import 'pages/category/category_page.dart';
import 'pages/favorite/favorite_page.dart';
import 'pages/home/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CommonAppBar(
          title: Text(language.appName),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                openScreen(context, SearchProductScreen());
              },
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Icon(Icons.search_outlined)),
            ),
            ValueListenableBuilder(
              valueListenable: cartBox.listenable(),
              builder: (context, value, child) {
                final cartData = getCartDataFromCartBox();
                return cartData.isEmpty ? Container() : _cartView(cartData);
              },
            ),
          ],
        ),
        body: SafeArea(child: _buildHomeScreen()),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        Expanded(child: TabBarView(physics: NeverScrollableScrollPhysics(), children: [HomePage(), CategoryPage(), FavoritePage(), AccountPage()])),
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
      child: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home_outlined)),
          Tab(icon: Icon(Icons.border_all_outlined)),
          Tab(icon: Icon(Icons.favorite_outline)),
          Tab(icon: Icon(Icons.person_outline)),
        ],
        dividerHeight: 0,
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        tabAlignment: TabAlignment.fill,
        labelColor: colorPrimary,
        unselectedLabelColor: colorBlack,
      ),
    );
  }

  Widget _cartView(List<ProductEntity> cartData) {
    return GestureDetector(
      onTap: () {
        openScreen(context, CartScreen());
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 10.w),
        child: Stack(
          children: [
            Icon(Icons.shopping_bag_outlined, color: colorBlack),
            Container(
              margin: EdgeInsetsDirectional.only(start: 11.w),
              decoration: BoxDecoration(shape: BoxShape.circle, color: colorPrimary),
              padding: EdgeInsets.all(4.sp),
              child: Text(cartData.length.toString(), style: bodyTextStyle(fontSize: 10.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
