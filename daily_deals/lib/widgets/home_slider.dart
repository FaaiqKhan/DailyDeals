import 'package:daily_deals/modals/slider_modal.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeSlider extends StatelessWidget {
  final List<SliderModal> _modal;
  final PageController _pageController = PageController(initialPage: 0);

  HomeSlider(this._modal);

  List<Widget> prepareData() {
    List<Widget> data = [];
    for (SliderModal modal in _modal) {
      data.add(
        Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(modal.photo!, fit: BoxFit.fill),
          ),
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.07;

    return Container(
      padding: EdgeInsets.only(
        left: Utils.screenPadding,
        right: Utils.screenPadding,
        bottom: Utils.elementPadding,
      ),
      width: screenWidth,
      height: screenWidth * 0.7,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            onPageChanged: (int) {},
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: prepareData(),
            physics: NeverScrollableScrollPhysics(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back arrow
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      _pageController.page!.toInt() - 1,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor("#707070"),
                      ),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: HexColor("#707070"),
                      size: iconSize,
                    ),
                  ),
                ),
                // Forward arrow
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      _pageController.page!.toInt() + 1,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor("#707070"),
                      ),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: HexColor("#707070"),
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
