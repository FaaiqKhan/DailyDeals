import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:daily_deals/widgets/remaining_product_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CurrentDeals extends StatelessWidget {
  final String title, productName, productImage, dealOn, price, endingTime;
  final String? remainingTime;

  CurrentDeals({
    this.title = "",
    this.productName = "",
    this.productImage = "",
    this.dealOn = "",
    this.price = "",
    this.remainingTime,
    this.endingTime = "",
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double elementSpacing = screenWidth * 0.03;
    return Card(
      color: Colors.transparent,
      elevation: 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              // Right size (Product details)
              Container(
                // width: cardWidth(screenWidth),
                decoration: BoxDecoration(
                  color: HexColor("#F83615"),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor("#303030")),
                          color: HexColor("#303030"),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "WIN",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle2!.fontFamily,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      this.title,
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1!.fontFamily,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.21),
                      child: Text(
                        this.productName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle2!.fontFamily,
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Image.asset(
                      this.productImage,
                      width: screenWidth * 0.35,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.33),
                      child: Text(
                        this.dealOn,
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle2!.fontFamily,
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "AED ${this.price}",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: elementSpacing + 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Prize Details",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              HexColor("#303030"),
                            ),
                          ),
                        ),
                        SizedBox(width: elementSpacing),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              HexColor("#DA2B0E"),
                            ),
                          ),
                        ),
                        SizedBox(width: elementSpacing + 10),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.03,
                    )
                  ],
                ),
              ),
              // Left size (Timing details)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: elementSpacing),
                    // Share and favorite icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.1803921568627451,
                          child: Icon(Icons.share_outlined, size: 28),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Opacity(
                                opacity: 0.1803921568627451,
                                child: Icon(
                                  Icons.favorite_outline_outlined,
                                  size: 28,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/timer_icon.png",
                                  scale: 4,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: HexColor("#303030"),
                                    border: Border.all(
                                      color: HexColor("#303030"),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 35),
                                    child: Text(
                                      "End on 26 Nov",
                                      style: TextStyle(
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .fontFamily,
                                          color: Colors.white,
                                          fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Opacity(
                      opacity: 0.25882352941176473,
                      child: Image.asset(
                        "assets/images/clock_icon.png",
                        scale: 9,
                      ),
                    ),
                    Text(
                      "Closing in",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                        color: HexColor("#5F5C5C"),
                      ),
                    ),
                    ClosingTimer(
                      Duration(days: 24, hours: 26, minutes: 25, seconds: 30),
                    ),
                  ],
                ),
              ),
            ],
          ),
          RemainingProductCount(
            total: 1024,
            remaining: 305,
          )
        ],
      ),
    );
  }

  double cardWidth(double screenWidth) {
    return screenWidth - (screenWidth * 0.3);
  }
}
