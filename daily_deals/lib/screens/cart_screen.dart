import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double elementSpacing = screenWidth * 0.05;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: Utils.calculateScreenLeftRightPaddingWithTop(10),
            child: Column(
              children: [
                CartCard("15,000"),
                SizedBox(width: 300, child: Divider(thickness: 1)),
                CartCard("4,000"),
                SizedBox(width: 300, child: Divider(thickness: 1)),
                CartCard("5,000"),
                SizedBox(width: 300, child: Divider(thickness: 1)),
                CartCard("10,000"),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
        ProductDetailsView(screenWidth, "330.00", "3", "2"),
        AddToCartButton(
          screenWidth,
          "Checkout",
          () {
            showModalBottomSheet(
              context: context,
              backgroundColor: HexColor("#313030"),
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              builder: (ctx) {
                return Container(
                  height: screenHeight - 100,
                  child: Column(
                    children: [
                      SizedBox(height: elementSpacing),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: screenWidth * 0.5),
                        child: Text(
                          "What Do You Want To Do With Your Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .fontFamily,
                          ),
                        ),
                      ),
                      SizedBox(height: elementSpacing),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
