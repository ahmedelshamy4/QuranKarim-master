import 'dart:math';

import 'package:adhan/adhan.dart';
import 'package:after_layout/after_layout.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/providers/time_provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import '../../app_components.dart';
import '../../model/prayer_time.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/theme/color.dart';

class PrayerTimesCompass extends StatefulWidget {
  final PrayerTimes prayerTimes;

  const PrayerTimesCompass({Key? key, required this.prayerTimes})
      : super(key: key);

  @override
  State<PrayerTimesCompass> createState() => _PrayerTimesCompassState();
}

class _PrayerTimesCompassState extends State<PrayerTimesCompass>
    with AfterLayoutMixin {
  late TimeProvider timeProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<TimeProvider>().initializeTimer();
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    timeProvider = Provider.of<TimeProvider>(context, listen: false);
  }

  @override
  void dispose() {
    timeProvider.disposeData();
    super.dispose();
  }

  List<PrayerTime> times(PrayerTimes prayerTimes) {
    return [
      PrayerTime(
          prayerName: 'fajr'.tr(),
          time: DateFormat.jm().format(prayerTimes.fajr)),
      PrayerTime(
          prayerName: 'sunrise'.tr(),
          time: DateFormat.jm().format(prayerTimes.sunrise)),
      PrayerTime(
          prayerName: 'dhuhr'.tr(),
          time: DateFormat.jm().format(prayerTimes.dhuhr)),
      PrayerTime(
          prayerName: 'asr'.tr(),
          time: DateFormat.jm().format(prayerTimes.asr)),
      PrayerTime(
          prayerName: 'maghrib'.tr(),
          time: DateFormat.jm().format(prayerTimes.maghrib)),
      PrayerTime(
          prayerName: 'isha'.tr(),
          time: DateFormat.jm().format(prayerTimes.isha)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeProvider>(
      builder: (context, provider, child) {
        return FadeInRight(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace2(),
                BuildDigitalClock(
                  time:
                      '${provider.timeOfDay.hourOfPeriod}:${provider.timeOfDay.minute}',
                  period: provider.period(),
                ),
                BuildAnalogClock(
                  dateTime: provider.dateTime,
                ),
                verticalSpace2(),
                ListView.separated(
                  padding: padding2(),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: times(widget.prayerTimes).length,
                  itemBuilder: (_, index) {
                    return Container(
                      height: 50.h,
                      width: double.infinity,
                      padding: symmetricHorizontalPadding1(),
                      decoration: BoxDecoration(
                        color: transparent,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            times(widget.prayerTimes)[index].prayerName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            times(widget.prayerTimes)[index].time,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => verticalSpace2(),
                ),
                verticalSpace2(),
                Text(
                  'prayer_time_title'.tr(),
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                verticalSpace2(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildAnalogClock extends StatelessWidget {
  const BuildAnalogClock({Key? key, required this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(30, context)),
          child: AspectRatio(
            aspectRatio: isPortrait ? 1.2 : 1.5,
            child: Container(
              padding: padding3(),
              decoration: BoxDecoration(
                color: whiteColor.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(1, 1),
                      color: whiteColor.withOpacity(0.14),
                      blurRadius: 64,
                      spreadRadius: 5),
                ],
              ),
              child: Container(
                padding: padding3(),
                decoration: BoxDecoration(
                  color: whiteColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: whiteColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: CustomPaint(
                        painter: ClockPainter(context, dateTime),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Icon(
            Icons.brightness_4_outlined,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            size: 30.sp,
          ),
        ),
      ],
    );
  }
}

double getProportionateScreenHeight(double inputHeight, context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return (inputHeight / 896.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth, context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (inputWidth / 414.0) * screenWidth;
}

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;

  ClockPainter(this.context, this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);

    // Minute Calculation
    double minX =
        centerX + size.width * 0.32 * cos((dateTime.minute * 6) * pi / 180);
    double minY =
        centerY + size.width * 0.32 * sin((dateTime.minute * 6) * pi / 180);

    //Minute Line
    canvas.drawLine(
      center,
      Offset(minX, minY),
      Paint()
        ..color = Theme.of(context).primaryColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    // Hour Calculation
    // dateTime.hour * 30 because 360/12 = 30
    // dateTime.minute * 0.5 each minute we want to turn our hour line a little
    double hourX = centerX +
        size.width *
            0.25 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY +
        size.width *
            0.25 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    // hour Line
    canvas.drawLine(
      center,
      Offset(hourX, hourY),
      Paint()
        ..color = Theme.of(context).primaryColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    // Second Calculation
    // size.width * 0.4 define our line height
    // dateTime.second * 6 because 360 / 60 = 6
    double secondX =
        centerX + size.width * 0.32 * cos((dateTime.second * 6) * pi / 180);
    double secondY =
        centerY + size.width * 0.32 * sin((dateTime.second * 6) * pi / 180);

    // Second Line
    canvas.drawLine(
        center,
        Offset(secondX, secondY),
        Paint()
          ..color = Theme.of(context).primaryColor
          ..strokeWidth = 1.5);

// center Dots
    Paint dotPainter = Paint()..color = Theme.of(context).primaryColor;
    canvas.drawCircle(center, 20, dotPainter);
    canvas.drawCircle(
        center, 18, Paint()..color = Theme.of(context).backgroundColor);
    canvas.drawCircle(center, 8, dotPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
// class BuildAnalogClock extends StatelessWidget {
//   const BuildAnalogClock({Key? key, required this.dateTime}) : super(key: key);
//   final DateTime dateTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return FlutterAnalogClock(
//       dateTime: DateTime.now(),
//       dialPlateColor: Colors.white,
//       hourHandColor: Colors.black,
//       minuteHandColor: Colors.black,
//       secondHandColor: Colors.black,
//       numberColor: Colors.black,
//       borderColor: Colors.black,
//       tickColor: Colors.black,
//       centerPointColor: Colors.black,
//       showBorder: true,
//       showTicks: true,
//       showMinuteHand: true,
//       showSecondHand: true,
//       showNumber: true,
//       borderWidth: 8.0,
//       hourNumberScale: .10,
//       hourNumbers: [
//         'I',
//         'II',
//         'III',
//         'IV',
//         'V',
//         'VI',
//         'VII',
//         'VIII',
//         'IX',
//         'X',
//         'XI',
//         'XII'
//       ],
//       isLive: true,
//       width: 200.0,
//       height: 200.0,
//       decoration: const BoxDecoration(),
//       child: Text('Clock'),
//     );
//   }
// }

class BuildDigitalClock extends StatelessWidget {
  const BuildDigitalClock({Key? key, required this.time, required this.period})
      : super(key: key);
  final String time, period;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(
            color: whiteColor,
            fontSize: 60.sp,
          ),
        ),
        Text(
          period,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
