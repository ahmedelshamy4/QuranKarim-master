import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/providers/app_theme_provider.dart';

import '../../app_components.dart';
import '../../model/azkar/azkar_details.dart';
import '../../utils/theme/color.dart';

class BuildAzkarCategoryWidgetItem extends StatelessWidget {
  final String name;
  final VoidCallback onClick;

  const BuildAzkarCategoryWidgetItem(
      {Key? key, required this.name, required this.onClick})
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
            Image.asset(
              'assets/icons/azkar.png',
              height: 40.r,
              width: 40.r,
              fit: BoxFit.fill,
            ),
            horizontalSpace2(),
            Text(
              name,
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(height: 1.6),
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

class BuildAzkarDetailsItemWidget extends StatelessWidget {
  final AzkarDetails details;

  const BuildAzkarDetailsItemWidget({Key? key, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius(),
        gradient:
            context.select<AppThemeProvider, bool>((value) => value.isDark)
                ? darkGradient()
                : lightGradient(),
        border: Border.all(color: whiteColor, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.5, 0.5),
            spreadRadius: 1.5,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace2(),
          Row(
            children: [
              Container(
                height: 30.h,
                width: 60.w,
                alignment: Alignment.topRight,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0),
                    bottomEnd: Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${details.count} ${int.parse(details.count) > 1 ? 'many'.tr() : 'once'.tr()}',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.select<AppThemeProvider, bool>(
                                (value) => value.isDark)
                            ? mainDarkColor
                            : mainColor),
                  ),
                ),
              ),
              const Spacer(),
              copyButton(context, textValue: details.content),
              shareButton(textValue: details.content),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              details.content,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 18.sp, height: 1.8),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: symmetricHorizontalPadding1(),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Text(
                details.reference,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          verticalSpace2(),
          Container(
            width: double.infinity,
            padding: padding2(),
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10)),
            ),
            child: Selector<AppThemeProvider, bool>(
              selector: (context, provider) => provider.isDark,
              builder: (context, value, child) {
                return ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => value
                      ? const LinearGradient(
                              colors: [secondDarkColor, secondDarkColor])
                          .createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        )
                      : lightGradient().createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                  child: Text(
                    details.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold, height: 1.8),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
