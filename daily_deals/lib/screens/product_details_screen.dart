import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:daily_deals/widgets/app_bar_back_button.dart';
import 'package:daily_deals/widgets/app_bar_profile_button.dart';
import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = "/product-details";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sizeOfProduct = screenWidth * 0.25;
    double countContainerWidth = screenWidth * 0.4;
    double countContainerHeight = screenWidth * 0.15;
    double elementSpacing = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("Product Details"),
        leading: AppBarBackButton(),
        actions: [
          AppBarProfileButton()
        ],
      ),
      backgroundColor: HexColor("#FCF4F4"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Opacity(
                        opacity: 0.6509803921568628,
                        child: Icon(Icons.share_outlined, size: 28),
                      ),
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
                      Opacity(
                        opacity: 0.6509803921568628,
                        child: Icon(Icons.favorite_outline_outlined, size: 28),
                      ),
                    ],
                  ),
                  Image.asset("assets/images/dubai_jubilee_icon.png"),
                  Container(
                    width: sizeOfProduct,
                    height: sizeOfProduct,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Image.asset(
                      "assets/images/temp_3.png",
                      scale: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/mercedes_image.png'),
            Opacity(
              opacity: 0.25882352941176473,
              child: Image.asset(
                'assets/images/clock_icon.png',
                scale: 10,
              ),
            ),
            Text(
              "Closing in",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: HexColor("#5F5C5C"),
                fontStyle: FontStyle.italic,
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenWidth * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove, color: Colors.black),
                          Container(
                            alignment: Alignment.center,
                            width: countContainerWidth,
                            height: countContainerHeight,
                            decoration: BoxDecoration(
                                color: HexColor("#303030"),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "01",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.add, color: Colors.red),
                        ],
                      ),
                      SizedBox(height: elementSpacing),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              color: HexColor("#F83615"),
                              height: screenWidth * 0.11,
                              child: Text(
                                "Price Details",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .fontFamily,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              color: HexColor("#444343"),
                              height: screenWidth * 0.11,
                              child: Text(
                                "Price Details",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .fontFamily,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: elementSpacing),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Get a change To win",
                              style: TextStyle(
                                color: HexColor("#303030"),
                                fontSize: 17,
                              ),
                            ),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: screenWidth),
                              child: Text(
                                "2021 Mercedes AMZ-G63: UAE Golden Jubliee Edition",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .fontFamily,
                                  color: HexColor("#303030"),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: screenWidth),
                              child: Text(
                                "The 2021 Toyota Yaris is packed with style and is redesigned for every occasion. The Yaris’ dynamic front end conveys a high-grade look the moment you see it and its body lines create an impression",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .fontFamily,
                                  color: HexColor("#303030"),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ProductDetailsView(screenWidth, "330.00", "3", "2"),
                          AddToCartButton(screenWidth, "Add to cart", () {

                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.7,
                  child: ClosingTimer(
                    Duration(days: 6, hours: 16, minutes: 26, seconds: 46),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
