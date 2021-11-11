import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/closing_soon.dart';
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
              Container(
                width: screenWidth,
                height: screenWidth * 0.73,
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: HomeSlider(),
              ),
              Container(
                width: screenWidth,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: elementsDistance),
                    Text(
                      "Closing Soon",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: elementsDistance),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ClosingSoon(
                            "assets/images/temp_3.png",
                            "907 SOLD OUT OF 1050",
                          ),
                          SizedBox(width: screenWidth * 0.02,),
                          ClosingSoon(
                            "assets/images/temp_3.png",
                            "907 SOLD OUT OF 1050",
                          ),
                          SizedBox(width: screenWidth * 0.02,),
                          ClosingSoon(
                            "assets/images/temp_3.png",
                            "907 SOLD OUT OF 1050",
                          )
                        ],
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //         "assets/images/Closing-Deal.png",
                    //         scale: 1.5,
                    //       ),
                    //       SizedBox(width: elementsDistance),
                    //       Image.asset(
                    //         "assets/images/Closing-Deal02.png",
                    //         scale: 1.5,
                    //       ),
                    //       SizedBox(width: elementsDistance),
                    //       Image.asset(
                    //         "assets/images/Closing-Deal-03.png",
                    //         scale: 1.5,
                    //       ),
                    //       SizedBox(width: elementsDistance),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: elementsDistance),
                    Center(
                      child: Image.asset(
                        "assets/images/Pagination.png",
                        scale: 1.5,
                      ),
                    ),
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
                          Image.asset(
                            "assets/images/Cuurent-Deal.png",
                            scale: 1.5,
                          ),
                          SizedBox(width: elementsDistance),
                          Image.asset(
                            "assets/images/Cuurent-Deal.png",
                            scale: 1.5,
                          ),
                          SizedBox(width: elementsDistance),
                        ],
                      ),
                    ),
                    SizedBox(height: elementsDistance),
                    Center(
                      child: Image.asset(
                        "assets/images/Pagination.png",
                        scale: 1.5,
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
                          Image.asset(
                            "assets/images/Guesss-and-Win.png",
                            scale: 1.5,
                          ),
                          SizedBox(width: elementsDistance),
                          Image.asset(
                            "assets/images/Guesss-and-Win.png",
                            scale: 1.5,
                          ),
                          SizedBox(width: elementsDistance),
                        ],
                      ),
                    ),
                    SizedBox(height: elementsDistance),
                    Center(
                      child: Image.asset("assets/images/Pagination.png",
                          scale: 1.5),
                    ),
                    SizedBox(height: elementsDistance),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Deals(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset(
                        "assets/images/Winner.png",
                        scale: 1.5,
                      ),
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
