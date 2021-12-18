import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleProductView extends StatelessWidget {
  final String productName, productImage, productPrice;

  SingleProductView(
    this.productName,
    this.productImage,
    this.productPrice,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: HexColor("#F1F0F0"),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            productName,
            style: TextStyle(
              color: Colors.black,
              fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          FittedBox(child: Image.network(productImage)),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: HexColor("#363636"),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
                  ),
                ),
                Text(
                  productPrice,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
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
