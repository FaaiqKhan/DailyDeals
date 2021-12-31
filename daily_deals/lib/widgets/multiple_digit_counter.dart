import 'dart:async';

import 'package:daily_deals/screens/single_digit_screen.dart';
import 'package:flutter/material.dart';

class MultipleDigitCounter extends StatefulWidget {
  final String timeStamp;
  final bool useShrinkForm;

  MultipleDigitCounter(this.timeStamp, {Key? key, this.useShrinkForm = true})
      : super(key: key);

  @override
  MultipleDigitCounterState createState() => MultipleDigitCounterState();
}

class MultipleDigitCounterState extends State<MultipleDigitCounter> {
  int numberOfDigits = 8;
  int? timeStamp;
  List<SingleDigit> animatedDigits = [];

  int _value = 253;
  String? _oldValue;
  String? _newValue;
  Timer? _timer;

  int get value => _value;

  set value(int newValue) {
    _oldValue = value.toString();
    while (_oldValue!.length < numberOfDigits) {
      _oldValue = '0$_oldValue';
    }

    _value = newValue;

    _newValue = newValue.toString();
    while (_newValue!.length < numberOfDigits) {
      _newValue = '0$_newValue';
    }

    setState(() {
      for (var i = 0; i < numberOfDigits; i++) {
        if (_oldValue![i] != _newValue![i]) {
          animatedDigits[i].setValue(int.parse(_newValue![i]));
        }
      }
    });
  }

  String getValueAsString() {
    String val = _value.toString();
    while (val.length < numberOfDigits) {
      val = '0$val';
    }
    return val;
  }

  @override
  void initState() {
    List<String> digits = widget.timeStamp.split("");
    for (int i = 0; i < digits.length; i++) {
      if (i == 1 || i == 3 || i == 5) {
        animatedDigits.add(SingleDigit(
          initialValue: int.parse(digits[i]),
          showSeparator: true,
        ));
      } else {
        animatedDigits.add(SingleDigit(
          initialValue: int.parse(digits[i]),
          showSeparator: false,
        ));
      }
    }
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (animatedDigits.isEmpty) {
      String newValue = getValueAsString();

      for (var i = 0; i < newValue.length; i++) {
        var initialDigit = 0;
        if (_oldValue != null && _oldValue!.length > i) {
          initialDigit = int.parse(_oldValue![i]);
        }
        animatedDigits.add(SingleDigit(
          initialValue: initialDigit,
          showSeparator: false,
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: animatedDigits,
    );
  }

  void startTimer() {
    int _start = 100;
    const oneSec = const Duration(seconds: 1);
    try {
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) {
          if (_start == 0) {
            _timer!.cancel();
          } else {
            _start--;
            value = _start;
          }
        },
      );
    } catch(e) {
      if (_timer != null)
        _timer!.cancel();
      _timer = null;
    }
  }
}
