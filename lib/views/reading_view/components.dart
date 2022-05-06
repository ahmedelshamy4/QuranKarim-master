import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/providers/app_theme_provider.dart';

import '../../app_components.dart';
import '../../model/surah/surah.dart';
import '../../utils/theme/color.dart';

class BuildSurahItemWidget extends StatelessWidget {
  final Surah surah;
  final String surahType;
  final VoidCallback onClick;
  const BuildSurahItemWidget(
      {Key? key,
      required this.surah,
      required this.surahType,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 80.h,
        width: double.infinity,
        padding: symmetricHorizontalPadding1(),
        decoration: BoxDecoration(
          gradient:
              context.select<AppThemeProvider, bool>((value) => value.isDark)
                  ? darkGradient()
                  : lightGradient(),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.5, 0.5),
              spreadRadius: 1.5,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.brightness_5,
                  size: 60.sp,
                  color: whiteColor,
                ),
                Text(
                  surah.number.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold, height: 1.6),
                ),
              ],
            ),
            horizontalSpace2(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surah.name,
                  style: Theme.of(context).textTheme.headline2,
                ),
                verticalSpace1(),
                Text(
                  '${surah.ayahs.length} ${'ayah'.tr()} - $surahType',
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
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
    );
  }
}
