import 'package:daily_deals/utils/common/utilities.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'multiple_digit_counter.dart';

class ClosingTimer extends StatelessWidget {
  final int timeStamp;
  final bool useShrinkForm;
  final DateFormat format = DateFormat("ddHHmmss");

  ClosingTimer(this.timeStamp, {this.useShrinkForm = true});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    DateTime current = DateTime.now();
    if (dateTime.isAfter(current)) {
      bool setZero = dateTime.day <= current.day;
      Duration diffDuration = dateTime.difference(current);
      List<String> vaSplit = Utilities().formatDuration(diffDuration);
      List<int> data = [];
      for (String d in vaSplit) {
        data.add(int.parse(d));
      }
      dateTime = DateTime(
        current.year,
        current.month,
        data[0] == 0 ? current.day : data[0],
        data[1],
        data[2],
        data[3],
      );
      final digitCounter = MultipleDigitCounter(
        dateTime,
        format,
        useShrinkForm: useShrinkForm,
        setZero: setZero,
      );
      return Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: HexColor("#F22806"),
          border: Border.all(color: HexColor("#F22806")),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: digitCounter,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: HexColor("#F22806"),
          border: Border.all(color: HexColor("#F22806")),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Text("Expired", style: TextStyle(color: Colors.white)),
      );
    }
  }
}
