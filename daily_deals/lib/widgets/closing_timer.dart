import 'dart:async';

import 'package:daily_deals/providers/timer_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'multiple_digit_counter.dart';

class ClosingTimer extends StatelessWidget {
  final Duration endingTime;

  ClosingTimer(this.endingTime);

  @override
  Widget build(BuildContext context) {
    final MultipleDigitCounter digitCounter =
        MultipleDigitCounter(8, false, 253, endingTime);
    return Container(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: HexColor("#F22806"),
        border: Border.all(color: HexColor("#F22806")),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: DigitDisplayDemo(digitCounter),
    );
  }
}

Timer? _timer;
int _start = 10;

class DigitDisplayDemo extends StatelessWidget {
  final MultipleDigitCounter digitCounter;

  DigitDisplayDemo(this.digitCounter);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TimerValueProvider();
      },
      child: Center(
        child: Column(
          children: <Widget>[
            this.digitCounter,
            Consumer<TimerValueProvider>(
              builder: (_, sliderValueProvider, __) {
                return SizedBox.shrink();
                // return TextButton(
                //   onPressed: () {
                //     startTimer(sliderValueProvider);
                //   },
                //   child: Text("Start timer"),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  void startTimer(var sliderValueProvider) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _timer!.cancel();
        } else {
          _start--;
          sliderValueProvider.setValue(_start);
          // (counterKey.currentState as MultipleDigitCounterState).value = _start;
        }
      },
    );
  }
}
