import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ClosingSoon extends StatelessWidget {
  final String _imagePath;
  final String _countDetails;

  ClosingSoon(this._imagePath, this._countDetails);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.37,
      height: screenWidth * 0.55,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                  Center(
                    child: Image.asset(
                      _imagePath,
                      scale: 1,
                    ),
                  ),
                  Column(
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
                      Text(
                        "AED 7.500 WORTH OF GOLD",
                        style: TextStyle(
                          fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                          fontStyle: FontStyle.italic,
                          fontSize: 9,
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
              _countDetails,
              style: TextStyle(
                fontSize: 10,
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: HexColor("#303030"),
              ),
            ),
          ),
          // Timer view
          Container(
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
              children: [
                Image.asset(
                  "assets/images/clock_icon.png",
                  scale: 25,
                  color: Colors.white,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "23 Hours 52 min 45 sec",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
