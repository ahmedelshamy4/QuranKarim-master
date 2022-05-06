import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:hive/hive.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_karim/model/ayah/ayah.dart';
import 'package:quran_karim/model/surah/surah.dart';
import 'package:quran_karim/routes/app_route.dart';
import 'package:quran_karim/utils/constant/cache_key.dart';
import 'package:quran_karim/utils/helper/cache_helper.dart';
import 'package:quran_karim/utils/helper/dio_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_karim/utils/providers.dart';
import 'package:quran_karim/utils/theme/theme.dart';
import 'package:quran_karim/views/home_view/home_view.dart';
import 'package:quran_karim/views/welcome_view/welcome_view.dart';

import 'package:provider/provider.dart';
import '../../providers/app_theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    language: 'ar',
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  await Hive.initFlutter();
  Hive.registerAdapter(SurahAdapter());
  Hive.registerAdapter(AyahAdapter());
  DioHelper.init();
  CacheHelper.init();
  runApp(
    LocalizedApp(
      child: MultiProvider(
        providers: Providers.providers,
        child: const QuraniKarim(),
      ),
    ),
  );
}

class QuraniKarim extends StatelessWidget {
  const QuraniKarim({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context) => RefreshConfiguration(
        headerBuilder: () => const WaterDropHeader(),
        footerBuilder: () => const ClassicFooter(),
        headerTriggerDistance: 30.0,
        springDescription:
            const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        maxOverScrollExtent: 30,
        maxUnderScrollExtent: 0,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        child: MaterialApp(
          builder: (BuildContext context, Widget? widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Quran Karim ',
          initialRoute: CacheHelper.getBooleanData(key: isCachingQuran) == false
              ? WelcomeView.id
              : HomeView.id,
          routes: Routes.routes,
          localizationsDelegates: translator.delegates,
          locale: translator.activeLocale,
          supportedLocales: translator.locals(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.dartTheme,
          themeMode:
              AppThemeProvider().isDark ? ThemeMode.dark : ThemeMode.light,
          // themeMode:
          //     context.select<AppThemeProvider, bool>((value) => value.isDark)
          //         ? ThemeMode.dark
          //         : ThemeMode.light,
        ),
      ),
    );
  }
}
