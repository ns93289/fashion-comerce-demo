import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/colors.dart';
import 'data/dataSources/local/hive_helper.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'src/generated/l10n/app_localizations.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
final navigatorKey = GlobalKey<NavigatorState>();
late AppLocalizations language;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("Fashion");
  await initHiveBoxes();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        scaffoldMessengerKey: scaffoldKey,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorWhite),
          scaffoldBackgroundColor: colorWhite,
          appBarTheme: AppBarTheme(backgroundColor: colorWhite, surfaceTintColor: colorWhite, elevation: 5, shadowColor: colorShadow),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SplashScreen(),
        builder: (context, child) {
          if (AppLocalizations.of(context) != null) {
            language = AppLocalizations.of(context)!;
          }
          return child ?? Container();
        },
      ),
    );
  }
}
