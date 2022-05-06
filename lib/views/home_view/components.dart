import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/viewModel/assmaa_allah/assmaaAllah_view_model.dart';
import 'package:quran_karim/viewModel/quran/quran_view_model.dart';
import 'package:quran_karim/views/assmaaAllah_view/assmaaAllah_view.dart';
import 'package:quran_karim/views/azkar_view/azkar_views.dart';
import 'package:quran_karim/views/reading_view/reading_view.dart';
import 'package:quran_karim/views/tasbih_view/tasbih_view.dart';

import '../../app_components.dart';
import '../../utils/theme/color.dart';
import '../../viewModel/ahadith/ahadith_view_model.dart';
import '../ahadith_view/ahadith_view.dart';
import '../listening_view/ListeningView.dart';
import '../live_view/live_view.dart';
import '../prayer_times_view/prayerTimes_view.dart';
import '../qiplah_view/quibla_view.dart';
import '../radio_view/radio_view.dart';

class BuildHomePortraitLayout extends StatelessWidget {
  const BuildHomePortraitLayout({Key? key}) : super(key: key);

  List<BuildGridCategoryItem> portraitGridWidgets(BuildContext context) {
    return [
      BuildGridCategoryItem(
        title: 'read_moshaf'.tr(),
        icon: 'assets/icons/quran.png',
        onClick: () {
          context.read<QuranViewModel>().getLocalData();
          context.read<QuranViewModel>().getSurahData().then((value) {
            namedNavigator(context, ReadingView.id);
          });
        },
      ),
      BuildGridCategoryItem(
        title: 'listen_moshaf'.tr(),
        icon: 'assets/icons/mic.png',
        onClick: () {
          namedNavigator(context, ListeningView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'hades'.tr(),
        icon: 'assets/icons/prays.png',
        onClick: () {
          context.read<AhadithViewModel>().getAhadith(context);
          namedNavigator(context, AhadithView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'azkar'.tr(),
        icon: 'assets/icons/azkar.png',
        onClick: () {
          namedNavigator(context, AzkarView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'asmaa_allah'.tr(),
        icon: 'assets/icons/asmaa_allah.png',
        onClick: () {
          context.read<AssmaaAllahViewModel>().getAssmaaAllahAlhosna(context);
          namedNavigator(context, AssmaaAllahView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'tasbeh'.tr(),
        icon: 'assets/icons/tasbih.png',
        onClick: () {
          namedNavigator(context, TasbihView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'kebla'.tr(),
        icon: 'assets/icons/kaaba.png',
        onClick: () {
          namedNavigator(context, QiplahView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'times'.tr(),
        icon: 'assets/icons/time-zone.png',
        onClick: () {
          namedNavigator(context, PrayerTimesView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'radio'.tr(),
        icon: 'assets/icons/radio.png',
        onClick: () {
          namedNavigator(context, RadioView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'live'.tr(),
        icon: 'assets/icons/live.png',
        onClick: () {
          namedNavigator(context, LiveView.id);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          verticalSpace2(),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: portraitGridWidgets(context).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(5),
              child: portraitGridWidgets(context)[index],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildHomeLandScapeLayout extends StatelessWidget {
  const BuildHomeLandScapeLayout({Key? key}) : super(key: key);

  List<BuildGridCategoryItem> landScapeGridWidgets(BuildContext context) {
    return [
      BuildGridCategoryItem(
        title: 'read_moshaf'.tr(),
        icon: 'assets/icons/quran.png',
        onClick: () {
          context.read<QuranViewModel>().getLocalData();
          context.read<QuranViewModel>().getSurahData().then((value) {
            namedNavigator(context, ReadingView.id);
          });
        },
      ),
      BuildGridCategoryItem(
        title: 'listen_moshaf'.tr(),
        icon: 'assets/icons/mic.png',
        onClick: () {
          namedNavigator(context, ListeningView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'hades'.tr(),
        icon: 'assets/icons/prays.png',
        onClick: () {
          context.read<AhadithViewModel>().getAhadith(context);
          namedNavigator(context, AhadithView.id);
        },
      ),
      BuildGridCategoryItem(
        title: 'azkar'.tr(),
        icon: 'assets/icons/azkar.png',
        onClick: () {
          namedNavigator(context, AzkarView.id);
        },
      ),
      BuildGridCategoryItem(
          title: 'asmaa_allah'.tr(),
          icon: 'assets/icons/asmaa_allah.png',
          onClick: () {
            context.read<AssmaaAllahViewModel>().getAssmaaAllahAlhosna(context);
            namedNavigator(context, AssmaaAllahView.id);
          }),
      BuildGridCategoryItem(
        title: 'tasbeh'.tr(),
        icon: 'assets/icons/tasbih.png',
        onClick: () {
          namedNavigator(context, TasbihView.id);
        },
      ),
    ];
  }

  List<BuildListCategoryItem> landScapeListWidgets(BuildContext context) {
    return [
      BuildListCategoryItem(
        title: 'kebla'.tr(),
        icon: 'assets/icons/kaaba.png',
        onClick: () {
          namedNavigator(context, QiplahView.id);
        },
      ),
      BuildListCategoryItem(
        title: 'times'.tr(),
        icon: 'assets/icons/time-zone.png',
        onClick: () {
          namedNavigator(context, PrayerTimesView.id);
        },
      ),
      BuildListCategoryItem(
        title: 'radio'.tr(),
        icon: 'assets/icons/radio.png',
        onClick: () {
          namedNavigator(context, RadioView.id);
        },
      ),
      BuildListCategoryItem(
        title: 'live'.tr(),
        icon: 'assets/icons/live.png',
        onClick: () {
          namedNavigator(context, LiveView.id);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          verticalSpace2(),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: landScapeGridWidgets(context).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(5),
              child: landScapeGridWidgets(context)[index],
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.all(10.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: landScapeListWidgets(context).length,
            itemBuilder: (_, index) => landScapeListWidgets(context)[index],
            separatorBuilder: (_, index) => verticalSpace2(),
          ),
        ],
      ),
    );
  }
}

class BuildListCategoryItem extends StatelessWidget {
  final String title, icon;
  final VoidCallback onClick;

  const BuildListCategoryItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildDefaultGradientButton(
      height: 80.h,
      child: Padding(
        padding: symmetricHorizontalPadding1(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 60.r,
              width: 60.r,
              fit: BoxFit.fill,
            ),
            horizontalSpace2(),
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            horizontalSpace0(),
            const Spacer(),
            Row(
              children: [
                Text(
                  'go'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold, height: 1.6),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: whiteColor,
                  size: 18.sp,
                ),
              ],
            ),
          ],
        ),
      ),
      onClick: onClick,
    );
  }
}

class BuildGridCategoryItem extends StatelessWidget {
  final String title, icon;
  final VoidCallback onClick;

  const BuildGridCategoryItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildDefaultGradientButton(
      child: Padding(
        padding: padding2(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              height: 70.r,
              width: 70.r,
              fit: BoxFit.fill,
            ),
            verticalSpace4(),
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'go'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold, height: 1.6),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: whiteColor,
                  size: 18.sp,
                ),
              ],
            ),
          ],
        ),
      ),
      onClick: onClick,
    );
  }
}
