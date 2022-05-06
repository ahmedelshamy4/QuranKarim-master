import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/viewModel/elders/elders_view_model.dart';
import 'package:quran_karim/viewModel/elders/states.dart';
import 'package:quran_karim/viewModel/quran/quran_view_model.dart';

import '../../app_components.dart';
import '../../utils/theme/color.dart';
import 'SurahAudioView/surah_audio_view.dart';

class ListeningView extends StatelessWidget {
  static const id = 'ListeningView';

  const ListeningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(title: 'listen_moshaf'.tr()),
      body: Consumer<EldersViewModel>(
        builder: (context, provider, child) {
          if (provider.states == EldersStates.Initial) {
            provider.getElders(context);
            return const BuildLoadingWidget();
          } else if (provider.states == EldersStates.Loading) {
            return const BuildLoadingWidget();
          } else if (provider.states == EldersStates.Loaded) {
            return FadeInRight(
              child: ListView.separated(
                padding: padding2(),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return BuildDefaultGradientButton(
                    height: 60.h,
                    child: Padding(
                      padding: symmetricHorizontalPadding1(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.music_note,
                            size: 26.sp,
                            color: whiteColor,
                          ),
                          horizontalSpace2(),
                          Text(
                            provider.elders[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          horizontalSpace0(),
                          const Spacer(),
                          Text(
                            'go'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.bold, height: 1.6),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                    onClick: () {
                      context.read<QuranViewModel>().getLocalData();
                      materialNavigator(
                          context,
                          SurahAudioView(
                            elder: provider.elders[index],
                          ));
                    },
                  );
                },
                separatorBuilder: (_, index) => verticalSpace2(),
                itemCount: provider.elders.length,
              ),
            );
          } else {
            return BuildErrorWidget(
              errorResult: provider.error,
            );
          }
        },
      ),
    );
  }
}
