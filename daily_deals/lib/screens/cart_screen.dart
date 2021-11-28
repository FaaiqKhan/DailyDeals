import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/views/cart_address_details_view.dart';
import 'package:daily_deals/views/cart_item_view.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:daily_deals/widgets/delivery_modes.dart';
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
                  child: ListView(
                    children: [
                      SizedBox(height: elementSpacing),
                      // Title
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                        child: Text(
                          "What Do You Want To Do With Your Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .fontFamily,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: elementSpacing),
                      // Product details
                      CartItem(
                        itemType: 0,
                        sequenceOfNumbers: [11, 17, 32, 48, 99, 20],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40.0,
                          right: 40.0,
                          bottom: 10.0,
                        ),
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      CartItem(itemType: 1),
                      CartAddressDetailsView(),
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
