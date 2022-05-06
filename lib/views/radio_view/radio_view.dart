import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../../app_components.dart';
import '../../model/error_result.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/helper/size_configration_helper.dart';
import '../../utils/theme/color.dart';
import '../../viewModel/radio/radio_view_model.dart';
import '../../viewModel/radio/states.dart';

class RadioView extends StatefulWidget {
  static const String id = 'RadioView';

  const RadioView({Key? key}) : super(key: key);

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<RadioViewModel>().playRadio(_player);
    });
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        SizeConfigurationHelper.screenOrientation == Orientation.portrait;
    return Container(
      decoration: BoxDecoration(
        gradient:
            context.select<AppThemeProvider, bool>((value) => value.isDark)
                ? darkGradient()
                : lightGradient(),
      ),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: buildDefaultAppBar(title: 'radio'.tr()),
        body: Consumer<RadioViewModel>(
          builder: (context, provider, child) {
            if (provider.states == RadioStates.Initial) {
              return const BuildLoadingWidget();
            } else if (provider.states == RadioStates.Loading) {
              return const BuildLoadingWidget();
            } else if (provider.states == RadioStates.Success) {
              return FadeInRight(
                child: Center(
                  child: Image.asset(
                    'assets/icons/radio.png',
                    height: isPortrait ? 250.h : 150.h,
                    width: isPortrait ? 220.w : 120.w,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            } else {
              return BuildErrorWidget(
                errorResult: ErrorResult(
                    errorMessage: 'error'.tr(),
                    errorImage: 'assets/icons/no-internet.png'),
              );
            }
          },
        ),
      ),
    );
  }
}
