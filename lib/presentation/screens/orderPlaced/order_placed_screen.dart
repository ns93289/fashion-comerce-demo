import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/custom_icons.dart';
import '../../../core/constants/theme.dart';
import '../../components/custom_button.dart';
import '../../provider/navigation_provider.dart';
import '../home/home_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../orderHistory/order_history_screen.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return PopScope(
          canPop: false,
          child: Scaffold(appBar: CommonAppBar(toolbarHeight: 0), body: _buildOrderPlaced()),
        );
      },
    );
  }

  Widget _buildOrderPlaced() {
    return Consumer(
      builder: (context, ref, _) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(CustomIcons.checkCircle, color: colorGreen, size: 140.sp),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 15.h, start: 20.w, end: 20.w),
              child: Text(language.orderPlacedSuccess, textAlign: TextAlign.center, style: bodyTextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold)),
            ),
            CustomButton(
              title: language.gotoOrderHistory,
              width: 1.sw,
              fontWeight: FontWeight.w500,
              height: 30.h,
              fontSize: 14.sp,
              margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 25.h),
              onPress: () {
                ref.read(navigationServiceProvider).navigateToWithClearStack(OrderHistoryScreen());
              },
            ),
            CustomButton(
              title: language.continueShopping,
              width: 1.sw,
              borderedButton: true,
              fontWeight: FontWeight.w500,
              height: 30.h,
              fontSize: 14.sp,
              margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
              onPress: () {
                ref.read(navigationServiceProvider).navigateToWithClearStack(HomeScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
