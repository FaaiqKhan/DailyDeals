import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationScreen extends StatelessWidget {
  Widget prepareView(double screenWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor("#F1F2F3"),
              ),
              width: screenWidth,
              height: screenWidth * 0.15,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: HexColor("#515C6F"),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Search Notification",
                    style: TextStyle(
                      color: HexColor("#515C6F"),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hoodie Deal",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 100),
                        Text(
                          "9:20 AM",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text("Lorem ipsum dolor sit amet"),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.7,
            )
          ],
        ),
      ),
    );
  }

  Widget emptyCartView(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "OOPS!",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Image.asset("assets/images/empty_notification_icon.png", scale: 3),
          Column(
            children: [
              Text(
                "Missing out on exciting notifications.",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Signup/login now",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Image.asset(
                "assets/images/smile_icon.png",
                scale: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: null,
      builder: (_, snapShot) {
        if (snapShot.hasData) {
          return [].isEmpty
              ? emptyCartView(context, screenWidth)
              : prepareView(screenWidth);
        } else {
          return emptyCartView(
              context, screenWidth); // WidgetUtils.progressIndicator(context);
        }
      },
    );
  }
}
