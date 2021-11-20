import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class DigitView extends StatelessWidget {
  final String digit;
  final String digitColor;
  final String boxColor;

  DigitView(this.digit, this.digitColor, this.boxColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: HexColor(boxColor),
      ),
      child: Text(
        digit,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: HexColor(digitColor),
        ),
      ),
    );
  }
}
