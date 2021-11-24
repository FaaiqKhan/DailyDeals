import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/views/card_view.dart';
import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:daily_deals/widgets/price_details_and_add_to_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GuessAndWin extends StatelessWidget {
  // final String tagLine, tagImage, dealOn, price, endingTime, priceImage;
  // final String winingItem;
  // final String? remainingTime;

  // GuessAndWin({
  //   this.tagLine = "",
  //   this.tagImage = "",
  //   this.dealOn = "",
  //   this.price = "",
  //   this.priceImage = "",
  //   this.winingItem = "",
  //   this.remainingTime,
  //   this.endingTime = "",
  // });
  final ProductModal _modal;

  GuessAndWin(this._modal);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double cardHeight = screenWidth * 0.89;
    double elementSpacing = screenWidth * 0.028;

    // Left size (Product details)
    Widget leftSide = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/clock_icon.png",
          scale: screenWidth * 0.032,
          color: Colors.white,
        ),
        SizedBox(height: elementSpacing),
        Container(
          padding: EdgeInsets.only(
            left: elementSpacing + 10,
            right: elementSpacing + 10,
          ),
          child: ClosingTimer(
            Duration(days: 60, hours: 15, minutes: 39, seconds: 35),
          ),
        ),
        SizedBox(height: elementSpacing),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.42),
          child: Text(
            "Hurry Up and participate before it's End!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Theme
                  .of(context)
                  .textTheme
                  .subtitle2!
                  .fontFamily,
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: elementSpacing),
        Image.asset("assets/images/runner_icon.png", width: screenWidth * 0.15),
        SizedBox(height: elementSpacing),
        Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/guess_win_box.png",
                  scale: 0.7,
                ),
                SizedBox(width: elementSpacing - 5),
                Image.asset(
                  "assets/images/guess_win_box.png",
                  scale: 0.7,
                ),
                SizedBox(width: elementSpacing - 5),
                Image.asset(
                  "assets/images/guess_win_box.png",
                  scale: 0.7,
                ),
                SizedBox(width: elementSpacing - 5),
                Image.asset(
                  "assets/images/guess_win_box.png",
                  scale: 0.7,
                ),
                SizedBox(width: elementSpacing - 5),
                Image.asset(
                  "assets/images/guess_win_box.png",
                  scale: 0.7,
                ),
              ],
            ),
            SizedBox(height: elementSpacing),
            Text(
              "Select your Lucky Number",
              style: TextStyle(
                fontFamily: Theme
                    .of(context)
                    .textTheme
                    .subtitle2!
                    .fontFamily,
                fontStyle: FontStyle.italic,
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            SizedBox(height: elementSpacing),
            TextButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Click Here",
                  style: TextStyle(
                    fontFamily:
                    Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .fontFamily,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  HexColor("#E62302"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    // Right size (Timing details)
    Widget rightSide = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.08, right: screenWidth * 0.08),
              child: Text(
                "Guess & win",
                style: TextStyle(
                  fontFamily: Theme
                      .of(context)
                      .textTheme
                      .subtitle2!
                      .fontFamily,
                  fontStyle: FontStyle.italic,
                  color: HexColor("#303030"),
                  fontSize: 24,
                ),
              ),
            ),
            Opacity(
              opacity: 0.1803921568627451,
              child: Icon(Icons.favorite_outline_outlined, size: 28),
            ),
          ],
        ),
        Text(
          _modal.title!,
          style: TextStyle(
            fontFamily: Theme
                .of(context)
                .textTheme
                .subtitle2!
                .fontFamily,
            color: HexColor("#ED4A2F"),
            fontSize: 9,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          "AED price",
          style: TextStyle(
            fontFamily: Theme
                .of(context)
                .textTheme
                .subtitle2!
                .fontFamily,
            color: HexColor("#ED4A2F"),
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: elementSpacing, right: elementSpacing),
          child: Image.network(
              _modal.image!,
              scale: 4
          )
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.33),
          child: Text(
            _modal.description!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Theme
                  .of(context)
                  .textTheme
                  .subtitle2!
                  .fontFamily,
              fontStyle: FontStyle.italic,
              fontSize: 10,
              color: HexColor("#303030"),
            ),
          ),
        ),
        Text(
          "AED price",
          style: TextStyle(
            fontFamily: Theme
                .of(context)
                .textTheme
                .subtitle2!
                .fontFamily,
            fontSize: 18,
            color: HexColor("#707070"),
          ),
        ),
        SizedBox(height: screenWidth * 0.05),
        PriceDetailsAndAddToCartButtons(),
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
