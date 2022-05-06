import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/app_components.dart';
import 'package:quran_karim/providers/tasbih_provider.dart';
import 'package:quran_karim/views/tasbih_view/my_popup_menu.dart';

import '../../providers/app_theme_provider.dart';
import '../../utils/theme/color.dart';

class TasbihView extends StatelessWidget {
  static const id = 'TasbihView';

  const TasbihView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(title: 'tasbeh'.tr()),
      body: Consumer<TasbihProvider>(
        builder: (context, provider, child) {
          return FadeInRight(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: symmetricHorizontalPadding1(),
                child: Column(
                  children: [
                    verticalSpace2(),
                    BuildDefaultGradientButton(
                      height: 60.h,
                      child: Padding(
                        padding: symmetricHorizontalPadding1(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.selectedValue,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 28.sp,
                              color: whiteColor,
                            ),
                          ],
                        ),
                      ),
                      onTapUp: (TapUpDetails? details) {
                        double dx = details!.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            color: Theme.of(context).primaryColor,
                            shape: OutlineInputBorder(
                              borderRadius: defaultBorderRadius(),
                              borderSide: const BorderSide(
                                  color: whiteColor, width: 1.5),
                            ),
                            items: provider.tasbihData
                                .map(
                                  (e) => MyPopUpMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              height: 2),
                                    ),
                                    onClick: () {
                                      provider.selectCurrentValue(value: e);
                                      provider.reset();
                                      popNavigate(context);
                                    },
                                  ),
                                )
                                .toList());
                      },
                    ),
                    verticalSpace4(),
                    GradientText(
                      provider.selectedValue,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: mainColor, fontSize: 28.sp),
                    ),
                    verticalSpace4(),
                    GradientText(
                      provider.tasbihNumber.toString(),
                      style: TextStyle(
                        fontSize: 45.sp,
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace2(),
                    GradientText(
                      'tasbih_number'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: mainColor, fontSize: 28.sp),
                    ),
                    verticalSpace1(),
                    BuildDefaultTextButton(
                      text: 'reset'.tr(),
                      fontSize: 22.sp,
                      buttonColor: context.select<AppThemeProvider, bool>(
                              (value) => value.isDark)
                          ? whiteColor
                          : mainColor,
                      onClick: () {
                        provider.reset();
                      },
                    ),
                    verticalSpace5(),
                    verticalSpace4(),
                    InkWell(
                      borderRadius: defaultBorderRadius(),
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      highlightColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      hoverColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                      onTap: () {
                        provider.tasbih();
                      },
                      child: Image.asset(
                        context.select<AppThemeProvider, bool>(
                                (value) => value.isDark)
                            ? 'assets/icons/dark_fingerprint.png'
                            : 'assets/icons/light_figerprint.png',
                        height: 140.w,
                        width: 140.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
