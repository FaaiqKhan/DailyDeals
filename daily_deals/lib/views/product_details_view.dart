import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetailsView extends StatelessWidget {
  final double screenWidth;
  final String productPrice;
  final String couponCount;
  final String productCount;

  ProductDetailsView(
    this.screenWidth,
    this.productPrice,
    this.couponCount,
    this.productCount,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.screenWidth,
      height: this.screenWidth * 0.35,
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
          Text(
            "AED $productPrice",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: new AlwaysStoppedAnimation(150 / 360),
                child: Image.asset(
                  "assets/images/coupon_icon.png",
                  scale: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "$couponCount Coupons $productCount Products",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
