import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/colors.dart';
import 'core/provider/locale_provider.dart';
import 'data/dataSources/local/hive_helper.dart';
import 'presentation/navigation/navigation_service.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'src/generated/l10n/app_localizations.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
late AppLocalizations language;
Locale selectedLocale = Locale(LanguageCodes.english);
late PackageInfo packageInfo;
final navigationService = NavigationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  await Hive.initFlutter("Fashion");
  await initHiveBoxes();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    selectedLocale = ref.watch(localeProvider);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: colorWhite, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark),
    );

    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldKey,
        navigatorKey: navigationService.navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorWhite),
          scaffoldBackgroundColor: colorWhite,
          dialogTheme: DialogTheme(backgroundColor: colorWhite, surfaceTintColor: colorWhite),
          appBarTheme: AppBarTheme(
            backgroundColor: colorWhite,
            surfaceTintColor: colorWhite,
            elevation: 5,
            shadowColor: colorShadow,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: colorWhite,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: selectedLocale,
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
