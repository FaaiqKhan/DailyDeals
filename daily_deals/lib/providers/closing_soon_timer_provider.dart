import 'dart:async';

import 'package:flutter/material.dart';

class ClosingSoonTimerProvider with ChangeNotifier {
  DateTime _now = DateTime.now();
  Timer? _timer;

  String get time {
    this.startTimer();
    return "${_now.hour} Hours ${_now.minute} Min ${_now.second} Sec";
  }

  void updateDuration() {
    _now = _now.subtract(Duration(seconds: 1));
    notifyListeners();
  }

  void startTimer() {
    if (_now.hour == 0 &&
        _now.minute == 0 &&
        _now.second == 0) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    } else {
      if (_timer == null) {
        const oneSec = const Duration(seconds: 1);
        _timer = new Timer.periodic(oneSec, (Timer timer) {
          this.updateDuration();
        });
      }
    }
  }
}
