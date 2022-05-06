import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/viewModel/quran/quran_view_model.dart';
import 'package:quran_karim/viewModel/quran/states.dart';
import 'package:quran_karim/views/reading_view/components.dart';
import 'package:quran_karim/views/reading_view/surah/surah_text_view.dart';
import 'package:after_layout/after_layout.dart';
import '../../app_components.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/theme/color.dart';

class ReadingView extends StatefulWidget {
  static const id = 'ReadingView';
  const ReadingView({Key? key}) : super(key: key);

  @override
  State<ReadingView> createState() => _ReadingViewState();
}

class _ReadingViewState extends State<ReadingView> with AfterLayoutMixin {
  late QuranViewModel _quranViewModel;
  @override
  void afterFirstLayout(BuildContext context) {
    _quranViewModel = Provider.of<QuranViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _quranViewModel.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuranViewModel>(
        builder: (context, provider, child) {
          if (provider.getLocalDataStates == QuranGetLocalDataStates.Loading) {
            return const BuildLoadingWidget();
          } else if (provider.getLocalDataStates ==
              QuranGetLocalDataStates.Loaded) {
            return FadeInRight(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    floating: true,
                    pinned: true,
                    snap: false,
                    title: Text(
                      'read_moshaf'.tr(),
                      style: const TextStyle(color: whiteColor),
                    ),
                    expandedHeight: 200.h,
                    flexibleSpace: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: kBottomNavigationBarHeight +
                            MediaQuery.of(context).viewPadding.top,
                      ),
                      padding: padding1(),
                      decoration: BoxDecoration(
                        gradient: context.select<AppThemeProvider, bool>(
                                (value) => value.isDark)
                            ? darkGradient()
                            : lightGradient(),
                      ),
                      child: GestureDetector(
                        onTap: () => materialNavigator(context,
                            SurahTextView(surah: provider.cachedSurah!)),
                        child: Card(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: transparent),
                          ),
                          child: Padding(
                            padding: padding1(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.asset('assets/images/quran.png'),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GradientText(
                                          'last_reading'.tr(),
                                          style: TextStyle(
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        verticalSpace2(),
                                        GradientText(
                                          provider.cachedSurah!.name,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GradientText(
                                          '${provider.cachedSurah!.ayahs.length} ${'ayah'.tr()} - ${provider.cachedSurah!.revelationType == 'Meccan' ? 'meccan'.tr() : 'medinan'.tr()}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Column(
                        children: [
                          index == 0 ? verticalSpace2() : const SizedBox(),
                          BuildSurahItemWidget(
                            surah: provider.quranData![index],
                            surahType:
                                provider.quranData![index].revelationType ==
                                        'Meccan'
                                    ? 'meccan'.tr()
                                    : 'medinan'.tr(),
                            onClick: () {
                              materialNavigator(
                                context,
                                SurahTextView(
                                  surah: provider.quranData![index],
                                ),
                              );
                            },
                          ),
                          verticalSpace2(),
                        ],
                      ),
                      childCount: provider.quranData!.length,
                    ),
                  )
                ],
              ),
            );
          } else {
            return BuildErrorWidget(
              errorResult: provider.error!,
            );
          }
        },
      ),
    );
  }
}
