import 'package:daily_deals/views/digit_view.dart';
import 'package:daily_deals/widgets/remaining_product_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CouponView extends StatelessWidget {
  final String title;
  final String productImage;
  final String priceName;
  final String productName;
  final String price;
  final String date;
  final String year;

  CouponView(this.title, this.productImage, this.priceName, this.productName,
      this.price, this.date, this.year);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double elementSpacing = screenWidth * 0.02;
    double containerHeight = screenWidth * 0.5;

    return Container(
      height: containerHeight,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        color: HexColor("#F7F7F7"),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // left side
                Container(
                  decoration: BoxDecoration(
                    color: HexColor("#F7F7F7"),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                  width: screenWidth * 0.38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle2!.fontFamily,
                          color: HexColor("#4E4C4C"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(productImage),
                      )
                    ],
                  ),
                ),
                // right side
                Container(
                  width: screenWidth * 0.53,
                  padding: EdgeInsets.only(
                    top: elementSpacing,
                    bottom: elementSpacing,
                    left: screenWidth * 0.07,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    color: HexColor("#F7F7F7"),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You appear in $priceName",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                              color: HexColor("#ACACAD"),
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            "luck draw by purchasing",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                              color: HexColor("#ACACAD"),
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            productName,
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              fontSize: 11,
                              color: HexColor("#4E4C4C"),
                            ),
                          ),
                          Text(
                            "AED $price",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              fontSize: 11,
                              color: HexColor("#4E4C4C"),
                            ),
                          ),
                        ],
                      ),
                      // Sequence
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your sequence",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                              color: HexColor("#ACACAD"),
                              fontSize: 9,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DigitView("11", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("17", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("32", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("48", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("99", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("20", "#ACACAD", "#E4E4E4"),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DigitView("11", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("17", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("32", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("48", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("99", "#ACACAD", "#E4E4E4"),
                              SizedBox(width: 5.0),
                              DigitView("20", "#ACACAD", "#E4E4E4"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: screenWidth * 0.32),
              child: RemainingProductCount(
                total: 100,
                remaining: 20,
                width: screenWidth * 0.12,
                height: screenWidth * 0.35,
              ),
            ),
            // Lottery icon
            Container(
              padding: EdgeInsets.only(top: screenWidth * 0.06, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/images/lottery_icon.png"),
                      Text(
                        "Lucky Draw",
                        style: TextStyle(
                          fontSize: 7,
                          color: HexColor("#ACACAD"),
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .fontFamily,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 7,
                          color: HexColor("#4E4C4C"),
                          fontFamily: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .fontFamily,
                        ),
                      ),
                      Text(
                        year,
                        style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#4E4C4C"),
                          fontFamily: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .fontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}