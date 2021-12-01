import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetailsView extends StatelessWidget {
  final double screenWidth;
  final double totalPrice;

  ProductDetailsView(this.screenWidth, this.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.screenWidth,
      height: this.screenWidth * 0.32,
      decoration: BoxDecoration(
        color: HexColor("#313030"),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Text(
            "Total amount inclusive VAT",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          SizedBox(height: 5.0),
          Text(
            "AED $totalPrice",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
