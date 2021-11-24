import 'package:daily_deals/modals/product_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/closing_timer.dart';
import 'card_view.dart';

class CurrentDeals extends StatelessWidget {
  final ProductModal _modal;

  CurrentDeals(this._modal);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double elementSpacing = screenWidth * 0.03;
    double cardHeight = screenWidth * 0.89;

    // Left size (Product details)
    Widget leftSide = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: HexColor("#303030")),
              color: HexColor("#303030"),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            "WIN",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          _modal.title!,
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            fontSize: 10,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.21),
          child: Text(
            "ok",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
        Image.network(
          _modal.image!,
          width: screenWidth * 0.35,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.33),
          child: Text(
            _modal.description!,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontStyle: FontStyle.italic,
              fontSize: 10,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          "AED price",
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            SizedBox(width: elementSpacing + 10),
            TextButton(
              onPressed: () {},
              child: Text(
                "Prize Details",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  HexColor("#303030"),
                ),
              ),
            ),
            SizedBox(width: elementSpacing),
            TextButton(
              onPressed: () {},
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  HexColor("#DA2B0E"),
                ),
              ),
            ),
            SizedBox(width: elementSpacing + 10),
          ],
        ),
        SizedBox(
          height: screenWidth * 0.03,
        )
      ],
    );
    // Right size (Timing details)
    Widget rightSide = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: elementSpacing),
        // Share and favorite icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Share option
            Opacity(
              opacity: 0.1803921568627451,
              child: Icon(Icons.share_outlined, size: 28),
            ),
            SizedBox(
              width: screenWidth * 0.45,
            ),
            Opacity(
              opacity: 0.1803921568627451,
              child: Icon(
                Icons.favorite_outline_outlined,
                size: 28,
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
          ],
        ),
        Container(
          width: screenWidth * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/timer_icon.png", scale: 4),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: HexColor("#303030"),
                  border: Border.all(
                    color: HexColor("#303030"),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 35),
                  child: Text(
                    "End on 26 Nov",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: 0.25882352941176473,
          child: Image.asset(
            "assets/images/clock_icon.png",
            scale: 9,
          ),
        ),
        Text(
          "Closing in",
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
            color: HexColor("#5F5C5C"),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: elementSpacing + 10),
            ClosingTimer(
              Duration(days: 24, hours: 26, minutes: 25, seconds: 30),
            ),
            SizedBox(width: elementSpacing + 10),
          ],
        ),
        SizedBox(
          height: screenWidth * 0.03,
        )
      ],
    );

    List<Widget> data = [leftSide, rightSide];

    return Container(
      height: cardHeight,
      child: CardView(
        data,
        totalItems: 1024,
        remainingItems: 800,
      ),
    );
  }
}
