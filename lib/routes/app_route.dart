import 'package:flutter/material.dart';
import 'package:quran_karim/views/assmaaAllah_view/assmaaAllah_view.dart';
import 'package:quran_karim/views/azkar_view/azkar_views.dart';
import 'package:quran_karim/views/live_view/live_view.dart';
import 'package:quran_karim/views/radio_view/radio_view.dart';
import 'package:quran_karim/views/tasbih_view/tasbih_view.dart';
import '../views/ahadith_view/ahadith_view.dart';
import '../views/home_view/home_view.dart';
import '../views/listening_view/ListeningView.dart';
import '../views/prayer_times_view/prayerTimes_view.dart';
import '../views/qiplah_view/quibla_view.dart';
import '../views/reading_view/reading_view.dart';
import '../views/welcome_view/welcome_view.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    WelcomeView.id: (_) => const WelcomeView(),
    HomeView.id: (_) => const HomeView(),
    ReadingView.id: (_) => const ReadingView(),
    AzkarView.id: (_) => const AzkarView(),
    AhadithView.id: (_) => const AhadithView(),
    ListeningView.id: (_) => const ListeningView(),
    AssmaaAllahView.id: (_) => const AssmaaAllahView(),
    TasbihView.id: (_) => const TasbihView(),
    QiplahView.id: (_) => const QiplahView(),
    PrayerTimesView.id: (_) => const PrayerTimesView(),
    RadioView.id: (_) => const RadioView(),
    LiveView.id: (_) => const LiveView(),
  };
}
