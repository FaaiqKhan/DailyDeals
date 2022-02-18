import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_deals/modals/slider_modal.dart';
import 'package:daily_deals/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeSlider extends StatelessWidget {
  final List<SliderModal> _modal;
  HomeSlider(this._modal);

  List<Widget> prepareData(double screenWidth) {
    List<Widget> data = [];
    for (SliderModal modal in _modal) {
      data.add(
        Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Container(
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(modal.photo!, fit: BoxFit.fill),
            ),
          ),
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenWidth * 0.07;
    List<Widget> sliderData = prepareData(screenWidth);
    CarouselController buttonCarouselController = CarouselController();
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
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: screenHeight / 2.5,
              initialPage: 0,
              reverse: false,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
            ),
            items: sliderData,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back arrow
                GestureDetector(
                  onTap: () {
                    buttonCarouselController.previousPage();
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
                    buttonCarouselController.nextPage();
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
