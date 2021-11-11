import 'package:daily_deals/providers/current_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeSlider extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.09;

    return Stack(
      alignment: Alignment.center,
      children: [
        Consumer<CurrentPage>(
          builder: (_, currentPage, __) {
            return PageView(
              onPageChanged: (int) {},
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: currentPage.allPages,
              physics: NeverScrollableScrollPhysics(),
            );
          },
        ),
        Row(
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
      ],
    );
  }
}
