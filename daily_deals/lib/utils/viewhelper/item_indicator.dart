import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ItemIndicator extends StatelessWidget {
  final twoPi = pi * 2;
  final String label;
  final int remainingItems, totalItems;

  ItemIndicator(this.label, this.remainingItems, this.totalItems);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * 0.10;
    double negativeSize = size - (screenWidth * 0.015);
    double percent = remainingItems / totalItems;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                      startAngle: 0.0,
                      endAngle: twoPi,
                      stops: [percent, 0.0],
                      center: Alignment.center,
                      colors: [HexColor("#F22806"), Colors.white],
                    ).createShader(rect);
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: negativeSize,
                    height: negativeSize,
                    decoration: BoxDecoration(
                      color: HexColor("#303030"),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        remainingItems.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 7,
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
