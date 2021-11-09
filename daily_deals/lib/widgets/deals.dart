import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Deals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Container(
                width: cardWidth(screenWidth),
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
                    Text("Get at Chance To Win"),
                    Text("Apple Watch"),
                    Text("Series 7"),
                    Image.asset(
                      "assets/images/deals_machine.png",
                      width: 200,
                      height: 200,
                    ),
                    Text("Buy a pencil Set and"),
                    Text("make it yours"),
                    Text(
                      "AED 30.00",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
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
                        SizedBox(
                          width: 10,
                        ),
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Container(
                width: cardWidth(screenWidth),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.share_outlined,
                          size: 28,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 12,
                              ),
                              child: Icon(
                                Icons.favorite_outline_outlined,
                                size: 28,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/timer_icon.png",
                                  scale: 3,
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
                        scale: 8,
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
                    ClosingTimer(),
                  ],
                ),
              ),
            ],
          ),
          Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  double cardWidth(double screenWidth) {
    return screenWidth - (screenWidth * 0.3);
  }
}
