import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'multiple_digit_counter.dart';

class ClosingTimer extends StatelessWidget {
  final int timeStamp;
  final bool useShrinkForm;

  ClosingTimer(this.timeStamp, {this.useShrinkForm = true});

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("ddHHmmss");
    String time = format.format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    final MultipleDigitCounter digitCounter =
        MultipleDigitCounter(time, useShrinkForm: useShrinkForm);
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: HexColor("#F22806"),
        border: Border.all(color: HexColor("#F22806")),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: digitCounter,
    );
  }
}
