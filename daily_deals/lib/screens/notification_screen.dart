import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/widgets/app_bar_back_button.dart';
import 'package:daily_deals/widgets/app_bar_profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("Notification"),
        actions: [AppBarProfileButton()],
        backgroundColor: HexColor("#F83615"),
      ),
      body: SingleChildScrollView(
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
                  CircleAvatar(
                    backgroundColor: HexColor("#F5F5F5"),
                    radius: 30,
                    child: Image.asset("assets/images/temp_3.png"),
                  ),
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
              Divider(color: Colors.grey, thickness: 0.7,)
            ],
          ),
        ),
      ),
    );
  }
}
