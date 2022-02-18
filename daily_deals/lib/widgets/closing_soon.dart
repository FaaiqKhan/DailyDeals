import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/providers/closing_soon_timer_provider.dart';
import 'package:daily_deals/utils/common/utilities.dart';
import 'package:daily_deals/widgets/add_to_favorites.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ClosingSoon extends StatelessWidget {
  final ProductModal _modal;

  ClosingSoon(this._modal);

  @override
  Widget build(BuildContext context) {
    bool isExpired = true;
    bool setZero = false;
    double screenWidth = MediaQuery.of(context).size.width;
    var dateTime = DateTime.fromMillisecondsSinceEpoch(_modal.timeStamp * 1000);
    DateTime current = DateTime.now();
    if (dateTime.isAfter(current)) {
      isExpired = false;
      setZero = dateTime.day <= current.day;
      Duration diffDuration = dateTime.difference(current);
      List<String> vaSplit = Utilities().formatDuration(diffDuration);
      List<int> data = [];
      for (String d in vaSplit) {
        data.add(int.parse(d));
      }
      dateTime = DateTime(
        current.year,
        current.month,
        data[0] == 0 ? current.day : data[0],
        data[1],
        data[2],
        data[3],
      );
    }
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: _modal.dealId,
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
                          _modal.dealId!,
                          _modal.isFavorite,
                          isClosingSoon: true,
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
                          "AED ${_modal.price} WORTH OF GOLD",
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
                  child: Consumer<ClosingSoonTimerProvider>(
                      builder: (_, provider, __) {
                    if (provider.isNotSet) {
                      provider.dateTime = dateTime;
                      provider.isNotSet = false;
                      provider.setZero = setZero;
                      provider.startTimer();
                    }
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        provider.time,
                        style: TextStyle(
                          fontSize: 8,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1!.fontFamily,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
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
}
