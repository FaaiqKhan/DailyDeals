import 'package:daily_deals/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final BuildContext? context;
  final bool isFilled;
  final VoidCallback? functionality;
  final bool lightBlackColor;

  AppButton({
    required this.context,
    required this.text,
    required this.functionality,
    this.isFilled = true,
    this.lightBlackColor = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: Utils.calculateButtonHeight(screenWidth),
      width: screenWidth,
      child: OutlinedButton(
        onPressed: functionality,
        child: Text(
          text!,
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
            fontSize: 16,
            color: isFilled
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        style: OutlinedButton.styleFrom(
          primary: isFilled
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
          backgroundColor: isFilled
              ? (lightBlackColor
                  ? HexColor("#363637")
                  : Theme.of(context).primaryColor)
              : Colors.transparent,
          side: BorderSide(
            color:
                lightBlackColor ? HexColor("#363637") : Theme.of(context).primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
