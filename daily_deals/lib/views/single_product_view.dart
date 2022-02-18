import 'package:daily_deals/screens/product_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleProductView extends StatelessWidget {
  final String? productId;
  final String productName, productImage, productPrice;

  SingleProductView(
    this.productName,
    this.productImage,
    this.productPrice, {
    this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.productId != null) {
          Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: productId,
          );
        }
      },
      child: Container(
        padding:
            EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0, bottom: 10.0),
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
            Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 80,
                    minHeight: 100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Image.network(productImage),
                    ),
                  ),
                ),
                Visibility(
                  visible: this.productId != null,
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
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
      ),
    );
  }
}
