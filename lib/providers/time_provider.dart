import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TimeProvider extends ChangeNotifier {
  late Timer timer;
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateTime = DateTime.now();

  String period() {
    return timeOfDay.period == DayPeriod.am ? 'am'.tr() : 'pm'.tr();
  }

  void initializeTimer() {
    period();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      dateTime = DateTime.now();
      if (timeOfDay.minute != TimeOfDay.now().minute) {
        timeOfDay = TimeOfDay.now();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void disposeData() {
    timer.cancel();
  }
}
