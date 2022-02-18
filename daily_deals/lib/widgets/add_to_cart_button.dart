
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AddToCartButton extends StatelessWidget {
  final double screenWidth;
  final Function feature;
  final String text;

  AddToCartButton(this.screenWidth, this.text, this.feature);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        feature();
      },
      child: Container(
        alignment: Alignment.center,
        width: this.screenWidth,
        height: this.screenWidth * 0.13,
        decoration: BoxDecoration(
          color: HexColor("#F83615"),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Text(
          this.text,
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
