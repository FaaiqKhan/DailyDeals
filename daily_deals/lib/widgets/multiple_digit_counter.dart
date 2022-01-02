import 'dart:async';

import 'package:daily_deals/screens/single_digit_screen.dart';
import 'package:flutter/material.dart';

class MultipleDigitCounter extends StatefulWidget {
  final String timeStamp;
  final bool useShrinkForm;

  MultipleDigitCounter(this.timeStamp, {this.useShrinkForm = true});

  @override
  MultipleDigitCounterState createState() => MultipleDigitCounterState();
}

class MultipleDigitCounterState extends State<MultipleDigitCounter> {
  int numberOfDigits = 8;
  int? timeStamp;
  List<SingleDigit> animatedDigits = [];
  Map<int, String> timeId = {
    0: "Day",
    2: "Hours",
    4: "Min",
    6: "Sec",
  };

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
          showSeparator: false,
          useShrinkForm: widget.useShrinkForm,
        ));
      } else {
        animatedDigits.add(SingleDigit(
          initialValue: int.parse(digits[i]),
          showSeparator: false,
          useShrinkForm: widget.useShrinkForm,
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
    List<Widget> compiledForm = [];
    for (int i = 0; i < numberOfDigits; i = i + 2) {
      compiledForm.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              animatedDigits[i],
              animatedDigits[i + 1],
              Visibility(
                visible: i != 6,
                child: Text(
                  ":",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.useShrinkForm ? 8 : null,
                  ),
                ),
              ),
            ],
          ),
          Text(
            timeId[i] ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.useShrinkForm ? 8 : null,
            ),
          ),
        ],
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: compiledForm,
    );
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
            value = _start;
          }
        },
      );
    } catch (e) {
      if (_timer != null) _timer!.cancel();
      _timer = null;
    }
  }
}
