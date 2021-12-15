import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const String routeName = "/order-confirmation-screen";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              "assets/images/credit_card_icon.png",
              scale: 2.5,
              color: Colors.white,
            ),
            AppBarTitle("Order Confirmation"),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: HexColor("#FCF4F4"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset("assets/images/confirm_order.png", scale: 1.6),
                SizedBox(height: 30),
                Text("Order Accepted",
                    style: Theme.of(context).textTheme.subtitle2),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  ParentScreen.routeName,
                );
              },
              child: Text(
                "Thanks and Back To Deals",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
                  fontSize: 12,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(screenWidth, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
