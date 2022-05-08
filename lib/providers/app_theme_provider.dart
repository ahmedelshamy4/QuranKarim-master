import 'package:flutter/cupertino.dart';
import 'package:quran_karim/utils/helper/cache_helper.dart';

import '../utils/constant/cache_key.dart';

class AppThemeProvider extends ChangeNotifier {
  bool cacheTheme = CacheHelper.getBooleanData(key: themeKey);

  AppThemeProvider() {
    changeAppTheme(currentTheme: cacheTheme);
  }

  bool isDark = true;

  void changeAppTheme({bool? currentTheme, bool switchValue = false}) {
    if (currentTheme != null) {
      isDark = currentTheme;
      notifyListeners();
    } else {
      isDark = switchValue;
      CacheHelper.setBooleanData(key: themeKey, value: isDark);
      notifyListeners();
    }
  }
}
