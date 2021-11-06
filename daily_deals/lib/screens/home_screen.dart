import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/deals.dart';
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
    return Scaffold(
      body: ColorfulSafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
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
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Image.asset("assets/images/favorite_icon.png"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: elementsDistance,
              ),
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
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
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
              SizedBox(
                height: elementsDistance,
              ),
              // Slider
              Container(
                width: screenWidth,
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset("assets/images/Slider.png"),
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Text(
                      "Closing Soon",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.asset("assets/images/Closing-Deal.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                          Image.asset("assets/images/Closing-Deal02.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                          Image.asset("assets/images/Closing-Deal-03.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Center(
                      child: Image.asset("assets/images/Pagination.png"),
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Text(
                      "Current Deals",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.asset("assets/images/Cuurent-Deal.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                          Image.asset("assets/images/Cuurent-Deal.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Center(child: Image.asset("assets/images/Pagination.png")),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Text(
                      "GUESS & WIN",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.asset("assets/images/Guesss-and-Win.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                          Image.asset("assets/images/Guesss-and-Win.png"),
                          SizedBox(
                            width: elementsDistance,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Center(child: Image.asset("assets/images/Pagination.png")),
                    SizedBox(
                      height: elementsDistance,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset("assets/images/Winner.png"),
                    ),
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
