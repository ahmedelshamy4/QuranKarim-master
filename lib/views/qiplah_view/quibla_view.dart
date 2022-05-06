import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:provider/provider.dart';
import '../../providers/app_theme_provider.dart';
import '../../app_components.dart';
import '../../utils/theme/color.dart';
import 'components.dart';

class QiplahView extends StatelessWidget {
  static const String id = 'QiplahView';

  const QiplahView({Key? key}) : super(key: key);

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
        appBar: buildDefaultAppBar(title: 'kebla'.tr()),
        body: FutureBuilder<bool?>(
          future: FlutterQiblah.androidDeviceSensorSupport(),
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const BuildLoadingWidget();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error.toString()}",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }
            if (snapshot.data!) {
              return const Center(
                child: QiblahCompass(),
              );
            } else {
              return LocationErrorWidget(
                callback: () {},
              );
            }
          },
        ),
      ),
    );
  }
}
