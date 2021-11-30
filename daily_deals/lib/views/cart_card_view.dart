import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

class CartCardView extends StatefulWidget {
  final CartItemModal _modal;
  final Function? deleteFunction, notifyPriceAdd, notifyPriceSubtract;
  final bool isGuessAndWin;

  CartCardView(
    this._modal,
    this.deleteFunction,
    this.notifyPriceAdd,
    this.notifyPriceSubtract,
    this.isGuessAndWin,
  );

  @override
  State<CartCardView> createState() => _CartCardViewState();
}

class _CartCardViewState extends State<CartCardView> {
  double price = 0.0;
  double screenWidth = 0.0;
  double topBottomPadding = 12.0;
  double leftRightPadding = 10.0;
  double totalPrice = 0.0;

  @override
  void initState() {
    price = double.parse(widget._modal.price);
    totalPrice = widget._modal.itemCount * price;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (screenWidth == 0.0) {
      screenWidth = MediaQuery.of(context).size.width;
    }
    super.didChangeDependencies();
  }

  void updateObject() async {
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    await cartItemBox.put(widget._modal.productId, widget._modal);
    await cartItemBox.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth * 0.42,
      child: Card(
        color: HexColor("#F9F8F8"),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Opacity(
                      opacity: widget.isGuessAndWin ? 1.0 : 0.0,
                      child: Text(
                        "Guess and win",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Image.network(widget._modal.productImage, scale: 6),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              // Text details
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.25),
                    child: Text(
                      "AED ${widget._modal.price} Cash",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2!.fontFamily,
                        color: HexColor("#303030"),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    widget._modal.prize,
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
              // Delete and add items
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.deleteFunction != null)
                        widget.deleteFunction!(
                            widget._modal.productId, totalPrice);
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
                  ),
                  Row(
                    children: [
                      // Remove item from cart
                      GestureDetector(
                        onTap: () async {
                          if (widget._modal.itemCount > 1) {
                            setState(() {
                              widget._modal.itemCount--;
                              totalPrice = widget._modal.itemCount * price;
                            });
                            updateObject();
                            widget.notifyPriceSubtract!(price);
                          }
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
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                          "${widget._modal.itemCount}",
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
                          if (widget._modal.itemCount < 3) {
                            setState(() {
                              widget._modal.itemCount++;
                              totalPrice = widget._modal.itemCount * price;
                            });
                            updateObject();
                            widget.notifyPriceAdd!(price);
                          }
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
                    "AED $totalPrice",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.headline5!.fontFamily,
                      color: HexColor("#EE5335"),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
