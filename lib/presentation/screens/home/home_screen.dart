import 'package:fashion_comerce_demo/data/models/model_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/provider/home_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../cart/cart_screen.dart';
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
        appBar: CommonAppBar(
          title: Text(language.appName),
          centerTitle: true,
          leading: Icon(Icons.menu),
          actions: [Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Icon(Icons.search_outlined))],
        ),
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
    return ListView.builder(itemCount: drawerList.length, shrinkWrap: true, itemBuilder: (context, index) {
      final ModelDrawer item=drawerList[index];
      return Container(color: colorWhite,child: Row(children: [
        Expanded(child: Text(item.title,style: bodyTextStyle(),)),
        Icon(item.icon),
        Icon(item.icon),
      ],),);
    });
  }
}
