import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/notification_view.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Size? size;

  Widget prepareView() {
    return Padding(
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
            width: size!.width,
            height: size!.width * 0.15,
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
    );
  }

  Widget emptyCartView(BuildContext context) {
    return Container(
      width: size!.width,
      height: size!.height - 170,
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

  fetchNotifications() async {
    return await WebService.fetchNotifications();
  }

  @override
  void didChangeDependencies() {
    if (size == null) size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchNotifications(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: FutureBuilder(
          future: WebService.fetchNotifications(),
          builder: (_, snapShot) {
            if (snapShot.hasData) {
              List<NotificationView> notificationView =
                  snapShot.data as List<NotificationView>;
              if (notificationView.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    children: notificationView,
                  ),
                );
              } else {
                return emptyCartView(context);
              }
            } else {
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height - 200,
                child: WidgetUtils.progressIndicator(context),
              );
            }
          },
        ),
      ),
    );
  }
}
