import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'multiple_digit_counter.dart';

final counterKey = GlobalKey();

class ClosingTimer extends StatelessWidget {
  final int timeStamp;
  final bool useShrinkForm;

  ClosingTimer(this.timeStamp, {this.useShrinkForm = true});

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry? alignment = Alignment.center;
    double? containerWidth = MediaQuery.of(context).size.width * 0.7;
    if (useShrinkForm) {
      alignment = null;
      containerWidth = null;
    }
    DateFormat format = DateFormat("ddHHmmss");
    String d = format.format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    final MultipleDigitCounter digitCounter = MultipleDigitCounter(
      d,
      useShrinkForm: useShrinkForm,
      key: counterKey,
    );
    return Container(
      alignment: alignment,
      width: containerWidth,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: HexColor("#F22806"),
        border: Border.all(color: HexColor("#F22806")),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          digitCounter,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Days", style: TextStyle(color: Colors.white)),
              Text("Hours", style: TextStyle(color: Colors.white)),
              Text("Min", style: TextStyle(color: Colors.white)),
              Text("Sec", style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}