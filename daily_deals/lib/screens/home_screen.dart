import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/guess_and_win_view.dart';
import 'package:daily_deals/views/winners_view.dart';
import 'package:daily_deals/views/current_deals_view.dart';
import 'package:daily_deals/widgets/closing_soon_slider.dart';
import 'package:daily_deals/widgets/home_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  final double elementsDistance = 10;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsetsGeometry pagePadding =
        Utils.calculateScreenLeftRightPadding(screenWidth);
    double elementSpacing = screenWidth * 0.02;

    return Scaffold(
      body: ColorfulSafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top padding
              SizedBox(height: screenWidth * 0.05),
              // Top right icons
              Padding(
                padding: pagePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Image.asset("assets/images/person_icon.png"),
                      onTap: () {},
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      child: Image.asset("assets/images/favorite_icon.png"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: elementsDistance),
              // Top tab bar
              Container(
                color: HexColor("#EAEAEA"),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "Products",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "Closing Soon",
                          style: TextStyle(
                            color: HexColor("#C6BFBF"),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: HexColor("#EAEAEA"),
                          border: Border.all(
                            color: HexColor("#EAEAEA"),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "Today's Deal",
                          style: TextStyle(
                            color: HexColor("#C6BFBF"),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: HexColor("#EAEAEA"),
                          border: Border.all(
                            color: HexColor("#EAEAEA"),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "Winner",
                          style: TextStyle(
                            color: HexColor("#C6BFBF"),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: HexColor("#EAEAEA"),
                          border: Border.all(
                            color: HexColor("#EAEAEA"),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Slider
              HomeSlider(),
              // Other components
              Container(
                width: screenWidth,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Closing Soon",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ClosingSoonSlider(),
                    SizedBox(height: elementsDistance),
                    Text(
                      "Current Deals",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: elementsDistance),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CurrentDeals(
                            title: "Get a change to win",
                            productName: "Apple Watch Series 7",
                            productImage: "assets/images/watch_icon.png",
                            dealOn: "Buy a pencil set and make it yours",
                            price: "30.00",
                          ),
                          SizedBox(width: elementSpacing),
                          CurrentDeals(
                            title: "Get a change to win",
                            productName: "Apple Watch Series 7",
                            productImage: "assets/images/watch_icon.png",
                            dealOn: "Buy a pencil set and make it yours",
                            price: "30.00",
                            endingTime: "End on 26 Nov",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: elementsDistance),
                    Text(
                      "GUESS & WIN",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GuessAndWin(
                            tagLine:
                                "Hurry Up and participate before it's End!",
                            tagImage: "assets/images/runner_icon.png",
                            dealOn: "Buy a pencil set and make it yours",
                            price: "30.00",
                            priceImage: "assets/images/gold_pen.png",
                            winingItem: "Buy a pencil Set and make it yours!",
                          ),
                          SizedBox(width: elementsDistance),
                        ],
                      ),
                    ),
                    SizedBox(height: elementsDistance),
                    Winners(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
