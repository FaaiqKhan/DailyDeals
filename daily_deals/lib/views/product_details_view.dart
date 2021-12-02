import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetailsView extends StatelessWidget {
  final double screenWidth;
  final double totalPrice;
  final Color? color;
  final int? couponCount, productCount;

  ProductDetailsView(
    this.screenWidth,
    this.totalPrice, {
    this.color,
    this.couponCount = 0,
    this.productCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.screenWidth,
      height: color == null ? this.screenWidth * 0.32 : this.screenWidth * 0.24,
      decoration: BoxDecoration(
        color: color == null ? HexColor("#313030") : color,
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
          Visibility(
            visible: color != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: new AlwaysStoppedAnimation(-45 / 360),
                  child: Image.asset(
                    "assets/images/cart/coupon_icon.png",
                    scale: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  "${this.couponCount} Coupons ${this.productCount} Products",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
