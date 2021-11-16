import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'closing_soon.dart';

class ClosingSoonSlider extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dotWidth = screenWidth * 0.08;
    double dotHeight = screenWidth * 0.03;
    return Column(
      children: [
        Container(
          height: screenWidth * 0.65,
          child: PageView(
            onPageChanged: (int) {},
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClosingSoon(
                    "assets/images/temp_3.png",
                    "907 SOLD OUT OF 1050",
                    function: () {
                      Navigator.pushNamed(
                        context,
                        ProductDetails.routeName,
                      );
                    },
                  ),
                  ClosingSoon(
                    "assets/images/watch_icon.png",
                    "907 SOLD OUT OF 1050",
                  ),
                ],
              ),
              Row(
                children: [
                  ClosingSoon(
                    "assets/images/temp_3.png",
                    "907 SOLD OUT OF 1050",
                  ),
                  ClosingSoon(
                    "assets/images/watch_icon.png",
                    "907 SOLD OUT OF 1050",
                  ),
                ],
              )
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: 2,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: dotWidth,
              height: dotHeight,
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            dotDecoration: DotDecoration(
              width: dotWidth,
              height: dotHeight,
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
              verticalOffset: 0,
            ),
            spacing: 6.0,
            inActiveColorOverride: (i) => HexColor("#EEEEEE"),
          ),
        ),
      ],
    );
  }
}
