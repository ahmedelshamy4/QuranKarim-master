import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/providers/app_theme_provider.dart';
import 'package:quran_karim/utils/helper/size_configration_helper.dart';
import 'package:quran_karim/utils/theme/color.dart';
import 'package:share_plus/share_plus.dart';

import 'model/error_result.dart';

SizedBox horizontalSpace0() => SizedBox(width: 2.w);

SizedBox horizontalSpace2() => SizedBox(width: 10.w);

SizedBox horizontalSpace4() => SizedBox(width: 20.w);

SizedBox verticalSpace1() => SizedBox(height: 5.h);

SizedBox verticalSpace2() => SizedBox(height: 10.h);

SizedBox verticalSpace4() => SizedBox(height: 20.h);

SizedBox verticalSpace5() => SizedBox(height: 30.h);

EdgeInsets padding1() => const EdgeInsets.all(5);

EdgeInsets padding2() => const EdgeInsets.all(10);

EdgeInsets padding3() => const EdgeInsets.all(15);

EdgeInsets symmetricHorizontalPadding3() =>
    const EdgeInsets.symmetric(horizontal: 20);

EdgeInsets symmetricHorizontalPadding1() =>
    const EdgeInsets.symmetric(horizontal: 10);

EdgeInsets symmetricVerticalPadding1() =>
    const EdgeInsets.symmetric(vertical: 10);
//shareText
Future<void> shareText({required String textValue}) async {
  await Share.share(textValue);
}

BuildDefaultIconButton copyButton(BuildContext context,
        {required String textValue}) =>
    BuildDefaultIconButton(
      icon: Icons.copy,
      onClick: () => copyText(context, textValue: textValue),
    );

Future<void> copyText(BuildContext context, {required String textValue}) async {
  await Clipboard.setData(ClipboardData(text: textValue));
  showToast(toastValue: 'copy_text'.tr());
}

BuildDefaultIconButton shareButton({required String textValue}) =>
    BuildDefaultIconButton(
      icon: Icons.share,
      onClick: () => shareText(textValue: textValue),
    );

class BuildDefaultIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onClick;
  final Color color;

  const BuildDefaultIconButton(
      {Key? key,
      required this.icon,
      required this.onClick,
      this.color = whiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 26.sp,
        color: color,
      ),
      onPressed: onClick,
    );
  }
}

class BuildErrorWidget extends StatelessWidget {
  final ErrorResult errorResult;

  const BuildErrorWidget({Key? key, required this.errorResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 220.h,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        color: transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              errorResult.errorImage,
              height: 150.w,
              width: 150.w,
              fit: BoxFit.fill,
            ),
            Container(
              width: double.infinity,
              padding: padding2(),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: defaultBorderRadius(),
              ),
              child: Center(
                child: Text(
                  errorResult.errorMessage,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDefaultGradientButton extends StatelessWidget {
  final double height, width;
  final Widget child;
  final VoidCallback? onClick;
  final Function(TapUpDetails?)? onTapUp;

  const BuildDefaultGradientButton({
    Key? key,
    required this.child,
    this.onClick,
    this.onTapUp,
    this.height = 100.0,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      onTapUp: onTapUp,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient:
              context.select<AppThemeProvider, bool>((value) => value.isDark)
                  ? darkGradient()
                  : lightGradient(),
          borderRadius: defaultBorderRadius(),
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
        child: child,
      ),
    );
  }
}

class BuildVersionWidget extends StatelessWidget {
  const BuildVersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    'version'.tr(),
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GradientText(
                    ' ${snapshot.data?.version}',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          default:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  'version'.tr(),
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GradientText(
                  ' 1.0.0',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}

class BuildCustomDivider extends StatelessWidget {
  const BuildCustomDivider({Key? key, required this.margin}) : super(key: key);
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5,
      margin: margin,
      decoration: BoxDecoration(
        gradient:
            context.select<AppThemeProvider, bool>((value) => value.isDark)
                ? darkGradient()
                : lightGradient(),
      ),
    );
  }
}

//GradientText
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const GradientText(this.text, {Key? key, this.style, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AppThemeProvider, bool>(
      selector: (context, provider) => provider.isDark,
      builder: (context, value, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => value
              ? const LinearGradient(colors: [whiteColor, whiteColor])
                  .createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                )
              : lightGradient().createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
          child: Text(
            text,
            style: style,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}

//GradientIcon
class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const GradientIcon({Key? key, required this.icon, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AppThemeProvider, bool>(
      selector: (context, provider) => provider.isDark,
      builder: (context, value, child) {
        return ShaderMask(
            child: SizedBox(
              width: size * 1.2,
              height: size * 1.2,
              child: Icon(
                icon,
                size: size,
                color: Colors.white,
              ),
            ),
            shaderCallback: (Rect bounds) {
              final Rect rect = Rect.fromLTRB(0, 0, size, size);
              return value
                  ? const LinearGradient(colors: [whiteColor, whiteColor])
                      .createShader(rect)
                  : lightGradient().createShader(rect);
            });
      },
    );
  }
}

LinearGradient lightGradient() => const LinearGradient(
      colors: [Colors.purple, Color.fromARGB(255, 23, 21, 81)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

LinearGradient darkGradient() => const LinearGradient(
      colors: [
        mainDarkColor,
        mainDarkColor,
      ],
    );

AppBar buildDefaultAppBar({required String title}) => AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: const TextStyle(color: whiteColor),
      ),
    );

AppBar buildAppBar(BuildContext context) => AppBar(
      title: Text(
        'quran'.tr(),
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'ReemKufi',
          color: whiteColor,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 5.0),
          child: InkWell(
            child: Image.asset(
              'assets/icons/drawer_logo.png',
            ),
            onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return BuildAlertDialogWidget(
                    title: 'doaa_description'.tr(),
                    description: 'doaa'.tr(),
                  );
                }),
          ),
        )
      ],
    );

class BuildDialogGradientText extends StatelessWidget {
  final String text;
  final double fontSize;

  const BuildDialogGradientText(
      {Key? key, required this.text, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AppThemeProvider, bool>(
      builder: (context, provider, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => provider
              ? const LinearGradient(colors: [mainDarkColor, mainDarkColor])
                  .createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                )
              : lightGradient().createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
          child: Text(
            text,
            style: TextStyle(
                color: whiteColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                height: 2),
            textAlign: TextAlign.center,
          ),
        );
      },
      selector: (context, provider) => provider.isDark,
    );
  }
}

class BuildDefaultTextButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final double fontSize;
  final Color buttonColor;

  const BuildDefaultTextButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.fontSize = 16.0,
    this.buttonColor = mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: buttonColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onClick,
    );
  }
}

class BuildAlertDialogWidget extends StatelessWidget {
  final String description, title;

  const BuildAlertDialogWidget(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        SizeConfigurationHelper.screenOrientation == Orientation.portrait;
    return AlertDialog(
      contentPadding: padding2(),
      backgroundColor: transparent,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: padding1(),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: defaultBorderRadius(),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BuildDialogGradientText(
                    text: title,
                    fontSize: isPortrait ? 22.sp : 20.sp,
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 2.0,
                    height: 2.h,
                    endIndent: 10.0,
                    indent: 10.0,
                  ),
                  BuildDialogGradientText(
                    text: description,
                    fontSize: isPortrait ? 18.sp : 16.sp,
                  ),
                ],
              ),
            ),
            verticalSpace1(),
            GestureDetector(
              onTap: () => popNavigate(context),
              child: Container(
                height: 50.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: defaultBorderRadius(),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2.0),
                ),
                child: Center(
                    child: BuildDialogGradientText(
                  text: 'cancel'.tr(),
                  fontSize: 20.sp,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showToast({required String toastValue}) {
  Fluttertoast.showToast(
      msg: toastValue,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black87.withOpacity(0.5),
      fontSize: 16.sp);
}

BorderRadius defaultBorderRadius() => const BorderRadius.all(
      Radius.circular(10.0),
    );

void popNavigate(BuildContext context) => Navigator.pop(context);

void replacementNamedNavigator(BuildContext context, String routeName) =>
    Navigator.pushReplacementNamed(context, routeName);

class BuildLoadingWidget extends StatelessWidget {
  const BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (Platform.isAndroid)
          ? CircularProgressIndicator(
              valueColor: context
                      .select<AppThemeProvider, bool>((value) => value.isDark)
                  ? const AlwaysStoppedAnimation<Color>(Colors.white)
                  : const AlwaysStoppedAnimation<Color>(mainColor),
            )
          : const CupertinoActivityIndicator(),
    );
  }
}

void namedNavigator(BuildContext context, String routeName) =>
    Navigator.pushNamed(context, routeName);

void materialNavigator(BuildContext context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
