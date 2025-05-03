import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../main.dart';
import '../../../customWidgets/common_app_bar.dart';
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
      length: 5,
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: CommonAppBar(
          title: Text(language.appName),
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
            children: [HomePage(), Text("Cart Page"), Text("Search Page"), Text("Favorite Page"), Text("Profile Page")],
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
              Tab(icon: Icon(Icons.shopping_cart_outlined)),
              Tab(icon: Icon(Icons.search, size: 0)),
              Tab(icon: Icon(Icons.favorite_outline)),
              Tab(icon: Icon(Icons.person_outline)),
            ],
            onTap: (value) {
              DefaultTabController.of(context).animateTo(value);
            },
            dividerHeight: 0,
            indicatorPadding: EdgeInsets.zero,
            indicatorColor: Colors.transparent,
            tabAlignment: TabAlignment.fill,
            labelColor: colorPrimary,
            unselectedLabelColor: colorBlack,
          ),
          Container(
            decoration: BoxDecoration(
              color: colorPrimary,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: colorBlack.withAlpha(10), blurRadius: 5, spreadRadius: 5)],
            ),
            padding: EdgeInsetsDirectional.all(5.sp),
            child: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
