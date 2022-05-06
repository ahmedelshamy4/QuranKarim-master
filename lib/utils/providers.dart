import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quran_karim/providers/app_theme_provider.dart';
import 'package:quran_karim/providers/change_font_size_provider.dart';
import 'package:quran_karim/providers/tasbih_provider.dart';
import 'package:quran_karim/providers/time_provider.dart';
import 'package:quran_karim/viewModel/ahadith/ahadith_view_model.dart';
import 'package:quran_karim/viewModel/assmaa_allah/assmaaAllah_view_model.dart';
import 'package:quran_karim/viewModel/azkar/azkar_view_model.dart';
import 'package:quran_karim/viewModel/elders/elders_view_model.dart';
import 'package:quran_karim/viewModel/radio/radio_view_model.dart';
import 'package:quran_karim/viewModel/surah_audio/audio_view_model.dart';

import '../providers/toggle_provider.dart';
import '../viewModel/prayer_times/prayer_times_views.dart';
import '../viewModel/quran/quran_view_model.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AppThemeProvider>(create: (_) => AppThemeProvider()),
    ChangeNotifierProvider<ToggleProvider>(create: (_) => ToggleProvider()),
    ChangeNotifierProvider<QuranViewModel>(create: (_) => QuranViewModel()),
    ChangeNotifierProvider<AzkarViewModel>(create: (_) => AzkarViewModel()),
    ChangeNotifierProvider<AhadithViewModel>(create: (_) => AhadithViewModel()),
    ChangeNotifierProvider<EldersViewModel>(create: (_) => EldersViewModel()),
    ChangeNotifierProvider<AudioViewModel>(create: (_) => AudioViewModel()),
    ChangeNotifierProvider<AssmaaAllahViewModel>(
        create: (_) => AssmaaAllahViewModel()),
    ChangeNotifierProvider<TasbihProvider>(create: (_) => TasbihProvider()),
    ChangeNotifierProvider<PrayerTimesViewModel>(
        create: (_) => PrayerTimesViewModel()),
    ChangeNotifierProvider<TimeProvider>(create: (_) => TimeProvider()),
    ChangeNotifierProvider<RadioViewModel>(create: (_) => RadioViewModel()),
    ChangeNotifierProvider<ChangeFontSizeProvider>(
        create: (_) => ChangeFontSizeProvider()),
  ];
}
