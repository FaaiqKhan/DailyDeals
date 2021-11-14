import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WinnerCard extends StatelessWidget {
  final String prizeImage, winnerName, reward, price;

  WinnerCard({
    required this.prizeImage,
    required this.winnerName,
    required this.reward,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/party_items.png",
                scale: 4,
                fit: BoxFit.fitWidth,
              ),
              Image.asset(prizeImage, scale: 5),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "CONGRATULATIONS",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Text(
            winnerName,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
              fontStyle: FontStyle.italic,
              color: HexColor("#303030"),
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            "On winning",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 10,
              color: HexColor("#303030"),
            ),
          ),
          Text(
            "AED $price" + " $reward",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 10,
              color: HexColor("#303030"),
            ),
          ),
          SizedBox(
            height: screenWidth * 0.09,
          )
        ],
      ),
    );
  }
}
