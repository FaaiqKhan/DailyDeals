import 'package:daily_deals/modals/product_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'closing_soon.dart';

class ClosingSoonSlider extends StatelessWidget {
  final List<ProductModal> _modal;
  final PageController _pageController = PageController(initialPage: 0);

  ClosingSoonSlider(this._modal);

  List<Widget> prepareData() {
    List<Widget> data = [];
    int dataLength = _modal.length;
    int halfOfList = dataLength ~/ 2;
    print(halfOfList);
    int endIndex = dataLength - 1;
    for (int i = 0; i <= halfOfList; i = i + 2) {
      data.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClosingSoon(_modal[i]),
            if (i != endIndex) ClosingSoon(_modal[i + 1]),
          ],
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dotWidth = screenWidth * 0.08;
    double dotHeight = screenWidth * 0.03;
    List<Widget> data = prepareData();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Closing Soon", style: Theme.of(context).textTheme.subtitle2),
        Container(
          height: screenWidth * 0.7,
          child: PageView(
            onPageChanged: (int) {},
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: data,
          ),
        ),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: data.length,
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
        ),
      ],
    );
  }
}
