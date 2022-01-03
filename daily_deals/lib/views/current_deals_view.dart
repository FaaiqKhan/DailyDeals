import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:daily_deals/widgets/add_to_favorites.dart';
import 'package:daily_deals/widgets/price_details_and_add_to_cart.dart';
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
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "WIN",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          // Tag line
          Text(
            "Get a change to win",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              fontSize: 8,
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
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          // Product Image
          Image.network(_modal.image!, scale: 5),
          // Product details
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.33),
            child: Text(
              _modal.subTitle!,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                fontStyle: FontStyle.italic,
                fontSize: 8,
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
              color: Colors.white,
            ),
          ),
          // Zero is identifier that shows these buttons are of current deals
          PriceDetailsAndAddToCartButtons(_modal, 0),
        ],
      ),
    );
    // Right size (Timing details)
    Widget rightSide = Container(
      width: (screenWidth / 2) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Share and favorite icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Share option
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Opacity(
                  opacity: 0.1803921568627451,
                  child: Icon(Icons.share_outlined, size: 28),
                ),
              ),
              AddToFavorites(_modal.dealId!, _modal.isFavorite),
            ],
          ),
          Image.asset("assets/images/timer_icon.png", scale: 7),
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
          Container(
            width: (screenWidth / 2 - 5),
            child: ClosingTimer(_modal.timeStamp),
          ),
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
