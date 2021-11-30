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
    double cardHeight = screenWidth * 0.8;

    // Left size (Product details)
    Widget leftSide = Container(
      width: (screenWidth / 2) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Win heading
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor("#303030")),
                color: HexColor("#303030"),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "WIN",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          // Tag line
          Text(
            "Get a change to win",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          // Product name
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.30),
            child: Text(
              _modal.title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          // Product Image
          Image.network(_modal.image!, scale: 4.5),
          // Product details
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.33),
            child: Text(
              _modal.subTitle!,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontStyle: FontStyle.italic,
                fontSize: 10,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Price
          Text(
            "AED ${_modal.price}",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Prize Details",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.subtitle2!.fontFamily,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 10,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    HexColor("#303030"),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.subtitle2!.fontFamily,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 10,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    HexColor("#DA2B0E"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // Right size (Timing details)
    Widget rightSide = Container(
      width: (screenWidth / 2) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Share and favorite icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Share option
              Opacity(
                opacity: 0.1803921568627451,
                child: Icon(Icons.share_outlined, size: 28),
              ),
              Opacity(
                opacity: 0.1803921568627451,
                child: Icon(
                  Icons.favorite_outline_outlined,
                  size: 28,
                ),
              ),
            ],
          ),
          // Runner image and date
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/timer_icon.png", scale: 6),
              SizedBox(width: 20),
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
                  constraints: BoxConstraints(maxWidth: 25),
                  child: Text(
                    "End on 26 Nov",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                      color: Colors.white,
                      fontSize: 7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          // Clock image
          Opacity(
            opacity: 0.25882352941176473,
            child: Image.asset("assets/images/clock_icon.png", scale: 12),
          ),
          // Closing in heading
          Text(
            "Closing in",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: HexColor("#5F5C5C"),
            ),
          ),
          // Timer
          ClosingTimer(
            Duration(days: 24, hours: 26, minutes: 25, seconds: 30),
          ),
        ],
      ),
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
