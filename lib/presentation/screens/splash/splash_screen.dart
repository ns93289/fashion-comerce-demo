import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/horizontal_loader.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../provider/splash_provider.dart';
import '../../../main.dart';

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
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Image.asset("assets/images/app_logo.png", width: 125.w)),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.h),
                child: Text(language.appName, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp, color: colorPrimary)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.h),
                child: Text(language.splashMs1, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.h),
                child: Text(language.splashMs2, style: bodyTextStyle(fontWeight: FontWeight.bold, color: colorTextLight)),
              ),
              Container(width: 125.w, margin: EdgeInsetsDirectional.only(top: 10.h), child: HorizontalLoader()),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.h),
                child: Text("${language.version} ${packageInfo.version}", style: bodyTextStyle(fontSize: 12.sp, color: colorTextLight)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
