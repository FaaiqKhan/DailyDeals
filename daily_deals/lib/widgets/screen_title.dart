import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final double screenWidth;

  ScreenTitle(this.title, this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 1,
          child: Image.asset(
            "assets/images/left_side_pattern.png",
            height: Utils.calculatePatternHeight(screenWidth),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ],
    );
  }
}
