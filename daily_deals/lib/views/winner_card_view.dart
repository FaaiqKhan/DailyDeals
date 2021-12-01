import 'package:daily_deals/modals/winner_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WinnerCard extends StatelessWidget {
  final WinnerModal modal;

  WinnerCard(this.modal);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.45,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            SizedBox(height: 5.0),
            Image.network(modal.image, scale: 5),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "CONGRATULATIONS",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              modal.customerName,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontStyle: FontStyle.italic,
                color: HexColor("#303030"),
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              "On winning",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 10,
                color: HexColor("#303030"),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              // "AED ${modal.amount}" + " ${modal.productName}",
              "AED ${modal.amount}",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 10,
                color: HexColor("#303030"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
