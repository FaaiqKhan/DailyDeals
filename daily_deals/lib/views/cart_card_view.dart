import 'package:daily_deals/providers/add_subtract_cart_item_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final String price;

  CartCard(this.price);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double topBottomPadding = 12.0;
    double leftRightPadding = 10.0;

    return Container(
      width: screenWidth,
      height: screenWidth * 0.42,
      child: Card(
        color: HexColor("#F9F8F8"),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: leftRightPadding,
            top: topBottomPadding,
            right: leftRightPadding,
            bottom: topBottomPadding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image and Text
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: true,
                      child: Text(
                        "Guess and win",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Image.asset(
                      "assets/images/gold_pen.png",
                      scale: 6,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.25),
                    child: Text(
                      "AED $price Cash",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2!.fontFamily,
                        color: HexColor("#303030"),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    "Pencil set",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1!.fontFamily,
                      color: HexColor("#C4C1CA"),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.25),
                    child: Text(
                      "You will get 2 coupons pet unit if donate",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1!.fontFamily,
                      ),
                    ),
                  )
                ],
              ),
              Consumer<AddSubtractCartItemProvider>(
                builder: (ctx, cartItems, deleteIcon) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      deleteIcon!,
                      Row(
                        children: [
                          // Remove item from cart
                          GestureDetector(
                            onTap: () {
                              if (cartItems.items > 1) cartItems.removeItem();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#F3F3F3"),
                              ),
                              child: Opacity(
                                opacity: 0.30980392156862746,
                                child: Icon(Icons.remove),
                              ),
                            ),
                          ),
                          // Items count
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              top: 5.0,
                              right: 10.0,
                              bottom: 5.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: HexColor("#313030"),
                            ),
                            child: Text(
                              cartItems.items.toString(),
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .fontFamily,
                              ),
                            ),
                          ),
                          // Add item in cart
                          GestureDetector(
                            onTap: () {
                              cartItems.addItem();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#F3F3F3"),
                              ),
                              child: Opacity(
                                opacity: 0.30980392156862746,
                                child: Icon(Icons.add),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "AED ${cartItems.items * 300.00}",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.headline5!.fontFamily,
                          color: HexColor("#EE5335"),
                          fontSize: 16,
                        ),
                      )
                    ],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor("#EFEDED"),
                  ),
                  child: Opacity(
                    opacity: 0.30980392156862746,
                    child: Icon(Icons.delete, size: 17),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
