import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:daily_deals/views/card_view.dart';
import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:daily_deals/widgets/price_details_and_add_to_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:daily_deals/widgets/add_to_favorites.dart';

class GuessAndWin extends StatelessWidget {
  final ProductModal _modal;

  GuessAndWin(this._modal);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenWidth * 0.85;
    double elementSpacing = screenWidth * 0.028;

    // Left size (Product details)
    Widget leftSide = Container(
      width: (screenWidth / 2) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/clock_icon.png",
            scale: 20,
            color: Colors.white,
          ),
          SizedBox(height: elementSpacing),
          Container(
            width: (screenWidth / 2) - 5,
            child: ClosingTimer(_modal.timeStamp),
          ),
          SizedBox(height: elementSpacing),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.42),
            child: Text(
              "Hurry Up and participate before it's End!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 8,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: elementSpacing),
          Image.asset("assets/images/runner_icon.png",
              width: screenWidth * 0.13),
          SizedBox(height: elementSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 5),
              Image.asset(
                "assets/images/guess_win_box.png",
                scale: 0.9,
              ),
              Image.asset(
                "assets/images/guess_win_box.png",
                scale: 0.9,
              ),
              Image.asset(
                "assets/images/guess_win_box.png",
                scale: 0.9,
              ),
              Image.asset(
                "assets/images/guess_win_box.png",
                scale: 0.9,
              ),
              Image.asset(
                "assets/images/guess_win_box.png",
                scale: 0.9,
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: elementSpacing),
          Text(
            "Select your Lucky Number",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontStyle: FontStyle.italic,
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          SizedBox(height: elementSpacing),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ProductDetails.routeName,
                arguments: _modal.dealId,
              );
            },
            child: Text(
              "Click Here",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#E62302")),
              padding: MaterialStateProperty.all(EdgeInsets.all(8.0)),
            ),
          ),
        ],
      ),
    );
    // Right size (Timing details)
    Widget rightSide = Container(
      width: (screenWidth / 2) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title with favorite icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Guess & win",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  fontStyle: FontStyle.italic,
                  color: HexColor("#303030"),
                  fontSize: 24,
                ),
              ),
              AddToFavorites(_modal.dealId!, _modal.isFavorite),
            ],
          ),
          // Product title
          Text(
            _modal.title!,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: HexColor("#ED4A2F"),
              fontSize: 9,
              fontStyle: FontStyle.italic,
            ),
          ),
          // Price
          Text(
            "AED ${_modal.price}",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: HexColor("#ED4A2F"),
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
          // Product image
          Padding(
            padding: EdgeInsets.only(
              left: elementSpacing,
              right: elementSpacing,
            ),
            child: Image.network(_modal.image!, scale: 4),
          ),
          // Gift image
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.33),
            child: Text(
              _modal.subTitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontStyle: FontStyle.italic,
                fontSize: 10,
                color: HexColor("#303030"),
              ),
            ),
          ),
          Text(
            "AED ${_modal.price}",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 18,
              color: HexColor("#707070"),
            ),
          ),
          // One is identifier that shows these buttons are of current deals
          PriceDetailsAndAddToCartButtons(_modal, 1),
        ],
      ),
    );

    List<Widget> data = [leftSide, rightSide];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: _modal.dealId,
      ),
      child: Container(
        height: cardHeight,
        child: CardView(
          data,
          totalItems: _modal.total ?? 0,
          remainingItems: _modal.soldOut ?? 0,
        ),
      ),
    );
  }
}
