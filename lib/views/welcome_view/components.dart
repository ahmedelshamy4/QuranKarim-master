import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/utils/theme/color.dart';

import '../../app_components.dart';

class BuildWelcomeButton extends StatelessWidget {
  final double height, width, radius;
  final Color color;
  final String title;
  final VoidCallback onClick;

  const BuildWelcomeButton(
      {Key? key,
      this.height = 50,
      this.width = double.infinity,
      this.radius = 25,
      this.color = whiteColor,
      required this.title,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1.5, 1.5),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ]),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: mainColor),
          ),
        ),
      ),
    );
  }
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: transparent,
        content: Container(
          height: 130.h,
          width: 150.w,
          padding: padding3(),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: defaultBorderRadius(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BuildLoadingWidget(),
              verticalSpace2(),
              Text(
                'fetch_data'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: mainColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
