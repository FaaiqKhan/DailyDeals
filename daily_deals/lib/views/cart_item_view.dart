import 'package:daily_deals/widgets/delivery_modes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CartItemView extends StatelessWidget {
  final int itemType;
  final List<int>? sequenceOfNumbers;
  final String guessAndWin = "Guess and win";
  final String closingDeal = "You pick this from closing deal";

  CartItemView({this.itemType = 0, this.sequenceOfNumbers});

  @override
  Widget build(BuildContext context) {
    List<Widget> sequenceViews = [];
    if (sequenceOfNumbers != null) {
      sequenceViews = generateSequenceView(context, sequenceOfNumbers!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            itemType == 0 ? guessAndWin : closingDeal,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: Colors.white,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: CartCardView("100.0"),
        // ),
        Visibility(
          visible: itemType == 0,
          child: Column(
            children: [
              Text(
                "Your sequence of this section",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  top: 15.0,
                  right: 50.0,
                  bottom: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: sequenceViews,
                ),
              )
            ],
          ),
        ),
        DeliveryModes(deliveryPrice: "35.0"),
      ],
    );
  }

  List<Widget> generateSequenceView(BuildContext context, List<int> sequence) {
    List<Widget> sequenceViews = [];
    for (int number in sequence) {
      sequenceViews.add(
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: HexColor("#F83615"),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return sequenceViews;
  }
}
