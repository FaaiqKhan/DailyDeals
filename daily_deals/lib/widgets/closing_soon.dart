import 'dart:async';

import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/utils/common/utilities.dart';
import 'package:daily_deals/widgets/add_to_favorites.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ClosingSoon extends StatefulWidget {
  final ProductModal _modal;

  ClosingSoon(this._modal);

  @override
  State<ClosingSoon> createState() => _ClosingSoonState();
}

class _ClosingSoonState extends State<ClosingSoon> {
  bool isExpired = true;
  bool setZero = false;
  double screenWidth = 0;
  late DateTime dateTime;
  late DateTime current;
  Timer? _timer;

  @override
  void initState() {
    current = DateTime.now();
    dateTime = DateTime.fromMillisecondsSinceEpoch(
      widget._modal.timeStamp * 1000,
    );
    if (dateTime.isAfter(current)) {
      isExpired = false;
      Duration diffDuration = dateTime.difference(current);
      List<String> vaSplit = Utilities().formatDuration(diffDuration);
      List<int> data = [];
      for (String d in vaSplit) {
        data.add(int.parse(d));
      }
      print(data);
      setZero = data[0] == 0;
      dateTime = DateTime(
        current.year,
        current.month,
        data[0] == 0 ? current.day : data[0],
        data[1],
        data[2],
        data[3],
      );
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (screenWidth == 0) {
      screenWidth = MediaQuery.of(context).size.width;
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ClosingSoon oldWidget) {
    if (_timer == null) {
      startTimer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: widget._modal.dealId,
      ),
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
                        child: AddToFavorites(
                          widget._modal.dealId!,
                          widget._modal.isFavorite,
                          isClosingSoon: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Image.network(
                    widget._modal.image!,
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
                          "AED ${widget._modal.price} WORTH OF GOLD",
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
              "${widget._modal.soldOut} SOLD OUT OF ${widget._modal.total}",
              style: TextStyle(
                fontSize: 10,
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: HexColor("#303030"),
              ),
            ),
          ),
          // Timer view
          Container(
            alignment: Alignment.center,
            width: screenWidth * 0.43,
            padding: const EdgeInsets.only(
                left: 4.0, top: 4.0, bottom: 4.0, right: 4.0),
            decoration: BoxDecoration(
              color: HexColor("#F83615"),
              border: Border.all(
                color: HexColor("#F83615"),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/clock_icon.png",
                  scale: 25,
                  color: Colors.white,
                ),
                Visibility(
                  visible: !isExpired,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      getTime(setZero),
                      style: TextStyle(
                        fontSize: 8,
                        fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  replacement: Text(
                    "Expired",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void startTimer() {
    int _start = 1000;
    const oneSec = const Duration(seconds: 1);
    try {
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) {
          if (_start == 0) {
            _timer!.cancel();
          } else {
            _start--;
            setState(() {
              dateTime = dateTime.subtract(Duration(seconds: 1));
            });
          }
        },
      );
    } catch (e) {
      if (_timer != null) _timer!.cancel();
      _timer = null;
    }
  }

  String getTime(bool setZero) {
    if (setZero) {
      return "0 Days ${dateTime.hour} Hours ${dateTime.minute} Min ${dateTime.second} Sec";
    }
    return "${dateTime.day} Days ${dateTime.hour} Hours ${dateTime.minute} Min ${dateTime.second} Sec";
  }

}
