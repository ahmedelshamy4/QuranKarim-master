import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/providers/app_theme_provider.dart';
import 'package:quran_karim/views/drawer_view/components.dart';

import '../../app_components.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: context.select<AppThemeProvider, bool>(
                          (value) => value.isDark)
                      ? darkGradient()
                      : lightGradient(),
                ),
                child: Image.asset(
                  'assets/images/quran.png',
                  height: 50.w,
                  width: 50.w,
                ),
              ),
              ListView.separated(
                padding: symmetricHorizontalPadding1(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return index == 0
                      ? const BuildVersionWidget()
                      : drawerItems(context)[index - 1];
                },
                separatorBuilder: (_, index) => index != 0
                    ? const BuildCustomDivider(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                      )
                    : const SizedBox(),
                itemCount: drawerItems(context).length + 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
