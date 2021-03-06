import 'dart:async';

import 'package:flutter/material.dart';

class ClosingSoonTimerProvider with ChangeNotifier {
  DateTime? _dateTime;
  Timer? _timer;
  bool isNotSet = true;
  bool _setZero = false;

  set dateTime(DateTime time) {
    this._dateTime = time;
  }

  set setZero(bool val) {
    this._setZero = val;
  }

  String get time {
    if (_setZero) {
      return "0 Days ${_dateTime!.hour} Hours ${_dateTime!.minute} Min ${_dateTime!.second} Sec";
    }
    return "${_dateTime!.day} Days ${_dateTime!.hour} Hours ${_dateTime!.minute} Min ${_dateTime!.second} Sec";
  }

  void startTimer() {
    int _start = 1000;
    const oneSec = const Duration(seconds: 1);
    try {
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_start == 0) {
            _timer!.cancel();
          } else {
            _start--;
            _dateTime = _dateTime!.subtract(Duration(seconds: 1));
            notifyListeners();
          }
        },
      );
    } catch (e) {
      if (_timer != null) _timer!.cancel();
      _timer = null;
    }
  }
}
