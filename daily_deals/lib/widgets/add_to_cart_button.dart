import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AddToCartButton extends StatelessWidget {
  final double screenWidth;

  AddToCartButton(this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.screenWidth,
      height: this.screenWidth * 0.18,
      decoration: BoxDecoration(
        color: HexColor("#F83615"),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Text(
        "Add To Cart",
        style: TextStyle(
          fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
          color: Colors.white,
          fontSize: 23,
        ),
      ),
    );
  }
}
