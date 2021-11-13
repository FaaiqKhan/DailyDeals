import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class RemainingProductCount extends StatelessWidget {
  final int total;
  final int remaining;

  RemainingProductCount({ this.total = 0, this.remaining = 0 });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double elementSpacing = screenWidth * 0.08;
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#303030"),
        border: Border.all(color: HexColor("#303030")),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Text(remaining.toString()),
          SizedBox(height: elementSpacing,),
          Text(total.toString()),
        ],
      ),
    );
  }

}