import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            CartCard("10,000")
          ],
        ),
      ),
    );
  }
}
