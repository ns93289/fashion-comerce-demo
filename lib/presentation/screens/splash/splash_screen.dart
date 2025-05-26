import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../provider/splash_provider.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../../main.dart';
import '../../../core/utils/tools.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void didChangeDependencies() {
    ref.read(splashActionProvider(context));
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
              child: Padding(padding: EdgeInsetsDirectional.only(top: 50.h), child: Text(language.appName, style: bodyStyle(fontWeight: FontWeight.w500))),
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
