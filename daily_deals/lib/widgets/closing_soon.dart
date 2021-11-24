import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/providers/closing_soon_timer_provider.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ClosingSoon extends StatelessWidget {
  final ProductModal _modal;

  ClosingSoon(this._modal);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth / 2.28,
            child: Card(
              color: HexColor("#F8F8F8"),
              elevation: 5.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: HexColor("#303030"),
                          border: Border.all(
                            color: HexColor("#303030"),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.favorite_outline_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Image.network(
                    _modal.image!,
                    width: screenWidth * 0.6,
                    height: screenWidth * 0.25,
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Get a change to win",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle2!.fontFamily,
                          fontStyle: FontStyle.italic,
                          color: HexColor("#FF0000"),
                          fontSize: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          "AED 7.500 WORTH OF GOLD",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .fontFamily,
                            fontStyle: FontStyle.italic,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Sold count
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              "${_modal.soldOut} SOLD OUT OF ${_modal.total}",
              style: TextStyle(
                fontSize: 10,
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: HexColor("#303030"),
              ),
            ),
          ),
          // Timer view
          Container(
            width: screenWidth * 0.43,
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 4.0,
              bottom: 4.0,
              right: 8.0,
            ),
            decoration: BoxDecoration(
              color: HexColor("#F83615"),
              border: Border.all(
                color: HexColor("#F83615"),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/clock_icon.png",
                  scale: 25,
                  color: Colors.white,
                ),
                SizedBox(width: screenWidth * 0.02),
                Consumer<ClosingSoonTimerProvider>(
                    builder: (_, ClosingSoonTimerProvider provider, __) {
                  return Text(
                    provider.time,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1!.fontFamily,
                      color: Colors.white,
                    ),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
