import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/current_deals_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ClosingSoonSlider extends StatelessWidget {
  final List<ProductModal> _modal;
  final PageController _pageController = PageController(initialPage: 0);
  final Axis scrollDirection;

  ClosingSoonSlider(this._modal, {this.scrollDirection = Axis.horizontal});

  List<Widget> prepareData1() {
    List<Widget> data = [];
    for (int i = 0; i < _modal.length; i++) {
      data.add(CurrentDeals(_modal.elementAt(i)));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool titleAndNavigatorRequired = scrollDirection == Axis.horizontal;
    List<Widget> data = titleAndNavigatorRequired
        ? Utils.prepareListDataForView(_modal, false)
        : prepareData1();
    double dotWidth = screenWidth * 0.08;
    double dotHeight = screenWidth * 0.03;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: titleAndNavigatorRequired,
          child: Text("Closing Soon",
              style: Theme.of(context).textTheme.subtitle2),
          replacement: SizedBox.shrink(),
        ),
        Container(
          height: screenWidth * 0.7,
          child: PageView(
            onPageChanged: (int) {},
            controller: _pageController,
            scrollDirection: scrollDirection,
            pageSnapping: true,
            children: data,
          ),
        ),
        Visibility(
          visible: titleAndNavigatorRequired,
          child: Center(
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
          replacement: SizedBox.shrink(),
        )
      ],
    );
  }
}
