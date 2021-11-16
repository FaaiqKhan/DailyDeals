import 'package:daily_deals/utils/viewhelper/item_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class RemainingProductCount extends StatelessWidget {
  final int total;
  final int remaining;

  RemainingProductCount({ this.total = 10, this.remaining = 5 });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerHeight = screenWidth * 0.34;
    double elementSpacing = containerHeight * 0.02;
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: HexColor("#303030"),
        border: Border.all(color: HexColor("#303030")),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: elementSpacing),
          ItemIndicator("Sold", remaining, total),
          SizedBox(height: elementSpacing),
          ItemIndicator("Total", total, total)
        ],
      ),
    );
  }

}