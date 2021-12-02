import 'package:daily_deals/modals/winner_modal.dart';
import 'package:daily_deals/views/winner_card_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WinnersScreen extends StatelessWidget {
  final double screenWidth;
  final List<WinnerModal>? modal;

  WinnersScreen(this.screenWidth, this.modal);

  List<Widget> prepareData(BuildContext context, List<WinnerModal>? data) {
    if (data == null) return [];
    List<Widget> views = [];
    for (int i = 0; i < data.length; i++) {
      if (i == 0) {
        views.add(Column(
          children: [
            SizedBox(height: screenWidth * 0.04),
            Image.asset("assets/images/announcement_icon.png", scale: 12),
            Text(
              "WINNERS",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 35,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            WinnerCard(
              data[i],
              fullScreenView: true,
            )
          ],
        ));
      } else {
        views.add(WinnerCard(
          data[i],
          fullScreenView: true,
        ));
      }
    }
    return views;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: screenWidth,
            height: screenWidth * 0.6,
            decoration: BoxDecoration(
              color: HexColor("#F83615"),
              image: DecorationImage(
                image: Image.asset("assets/images/party_items.png").image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(children: prepareData(context, modal))
        ],
      ),
    );
  }
}
