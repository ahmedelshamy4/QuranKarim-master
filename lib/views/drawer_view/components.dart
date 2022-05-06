import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/app_components.dart';
import 'package:quran_karim/providers/app_theme_provider.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../utils/theme/color.dart';

class BuildDrawerItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final bool isThemeToggle;

  const BuildDrawerItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
    this.isThemeToggle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding2(),
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: [
            GradientIcon(icon: icon, size: 24.sp),
            horizontalSpace4(),
            GradientText(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            !isThemeToggle
                ? GradientIcon(icon: Icons.arrow_forward_ios, size: 20.sp)
                : GradientIcon(
                    icon: context.select<AppThemeProvider, bool>(
                            (value) => value.isDark)
                        ? Icons.brightness_4_outlined
                        : Icons.brightness_4,
                    size: 24.sp,
                  ),

          ],
        ),
      ),
    );
  }
}

List<Widget> drawerItems(BuildContext context) {
  return [
    BuildDrawerItemWidget(
      title: 'about'.tr(),
      icon: Icons.help_outline,
      onClick: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: transparent,
            shape: const OutlineInputBorder(
              borderSide: BorderSide(color: transparent),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            builder: (_) {
              return Selector<AppThemeProvider, bool>(
                  builder: (context, value, child) {
                    return Container(
                      height: 250.h,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: value ? mainDarkColor : whiteColor,
                        borderRadius: const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20.0),
                          topStart: Radius.circular(20.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 5.0),
                              child: Divider(
                                thickness: 3,
                                color: mainColor,
                              ),
                            ),
                            GradientText(
                              'about_app'.tr(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  selector: (context, provider) => provider.isDark);
            });
      },
    ),
    BuildDrawerItemWidget(
      title: 'share_app'.tr(),
      icon: Icons.share,
      onClick: () => shareText(textValue: 'https://github.com/ahmedelshamy4'),
    ),
    BuildDrawerItemWidget(
      title: 'ratting_app'.tr(),
      icon: Icons.shop,
      onClick: () => StoreRedirect.redirect(),
    ),
    // BuildDrawerItemWidget(
    //   title: 'dark_mode'.tr(),
    //   icon: Icons.wb_sunny_outlined,
    //   isThemeToggle: true,
    //   onClick: () => context.read<AppThemeProvider>().changeAppTheme(),
    // )
  ];
}
