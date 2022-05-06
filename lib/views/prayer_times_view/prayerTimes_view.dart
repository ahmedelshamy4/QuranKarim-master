import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/viewModel/prayer_times/states.dart';

import '../../app_components.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/theme/color.dart';
import '../../viewModel/prayer_times/prayer_times_views.dart';
import '../qiplah_view/components.dart';
import 'components.dart';

class PrayerTimesView extends StatefulWidget {
  static const id = 'PrayerTimesView';

  const PrayerTimesView({Key? key}) : super(key: key);

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            context.select<AppThemeProvider, bool>((value) => value.isDark)
                ? darkGradient()
                : lightGradient(),
      ),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: buildDefaultAppBar(title: 'times'.tr()),
        body: Consumer<PrayerTimesViewModel>(
          builder: (context, provider, child) {
            if (provider.states == PrayerTimesStates.Initial) {
              provider.determinePosition();
              return const BuildLoadingWidget();
            } else if (provider.states == PrayerTimesStates.Loading) {
              return const BuildLoadingWidget();
            } else if (provider.states == PrayerTimesStates.Success) {
              return PrayerTimesCompass(
                prayerTimes: provider.prayerTimes,
              );
            } else {
              return LocationErrorWidget(
                error: 'enable_location'.tr(),
                callback: provider.determinePosition,
              );
            }
          },
        ),
      ),
    );
  }
}
