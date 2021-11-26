import 'package:daily_deals/utils/viewhelper/item_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class RemainingProductCount extends StatelessWidget {
  final int total;
  final int remaining;
  final double? width;
  final double? height;

  RemainingProductCount({
    this.total = 10,
    this.remaining = 5,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerHeight = (height == null ? (screenWidth * 0.25) : height!);
    return Container(
      width: width,
      height: containerHeight,
      decoration: BoxDecoration(
        color: HexColor("#303030"),
        border: Border.all(color: HexColor("#303030")),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ItemIndicator("Sold", remaining, total),
          ItemIndicator("Total", total, total)
        ],
      ),
    );
  }
}
