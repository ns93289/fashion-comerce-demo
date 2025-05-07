import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:fashion_comerce_demo/presentation/components/common_circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../../core/utils/tools.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      openScreen(context, HomeScreen());
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: Image.asset("assets/images/splash_image.webp")),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(padding: EdgeInsetsDirectional.only(top: 50.h), child: Text(language.appName, style: bodyTextStyle(fontWeight: FontWeight.w500))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(padding: EdgeInsetsDirectional.only(bottom: 20.h), child: CommonCircleProgressBar(color: colorBlack, stroke: 1.5.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
