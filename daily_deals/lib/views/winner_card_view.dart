import 'package:daily_deals/modals/winner_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WinnerCard extends StatelessWidget {
  final WinnerModal modal;
  final bool fullScreenView;

  WinnerCard(this.modal, {this.fullScreenView = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: fullScreenView ? screenWidth : screenWidth * 0.45,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            Image.network(
              modal.image,
              fit: fullScreenView ? BoxFit.fitWidth : BoxFit.fill,
              height: fullScreenView ? null : 150,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "CONGRATULATIONS",
                style: fullScreenView
                    ? TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.headline5!.fontFamily,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      )
                    : Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              modal.customerName,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontStyle: FontStyle.italic,
                color: HexColor("#303030"),
                fontSize: fullScreenView ? 20 : 12,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              "On winning",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: fullScreenView ? 16 : 10,
                color: HexColor("#303030"),
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              "AED ${modal.amount}",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: fullScreenView ? 16 : 10,
                color: HexColor("#303030"),
              ),
            ),
            Visibility(
              visible: fullScreenView,
              child: SizedBox(height: 20.0),
              replacement: SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
