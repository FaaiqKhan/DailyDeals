import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:daily_deals/providers/cart_item_provider.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/views/cart_address_details_view.dart';
import 'package:daily_deals/views/checkout_item_view.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  double totalPrice = 0.0;
  int productCount = 0;
  int itemCount = 0;
  CartCostProvider? cartCost;
  CartItemsProvider? cartItems;
  Map<String, int> isAddressRequired = {};
  Function? addressState;

  Future<List<CartItemModal>> getCartItem() async {
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    List<CartItemModal> items = cartItemBox.values.toList();
    await cartItemBox.close();
    return items;
  }

  Map<String, Widget> prepareView(List<CartItemModal> items) {
    totalPrice = 0.0;
    productCount = 0;
    itemCount = 0;
    Map<String, Widget> data = {};
    productCount = items.length - 1;
    for (int i = 0; i < productCount + 1; i++) {
      CartItemModal m = items[i];
      data[m.productId] = CartCardView(
        items[i],
        deleteFunction: deleteItem,
        notifyPriceAdd: addPrice,
        notifyPriceSubtract: minusPrice,
      );
      if (productCount != i)
        data[m.productId + "d"] =
            SizedBox(width: 300, child: Divider(thickness: 1));
      else
        data[m.productId + "d"] = SizedBox(height: 10);
      totalPrice = totalPrice + (double.parse(m.price) * m.itemCount);
      itemCount = itemCount + m.itemCount;
    }
    return data;
  }

  void addPrice(double price) {
    if (cartCost == null) return;
    this.totalPrice = this.totalPrice + price;
    itemCount++;
    cartCost!.updateCartValue(this.totalPrice, itemCount);
  }

  void minusPrice(double price) {
    if (cartCost == null) return;
    this.totalPrice = this.totalPrice - price;
    itemCount--;
    cartCost!.updateCartValue(this.totalPrice, itemCount);
  }

  void deleteItem(CartItemModal item, double totalPrice) async {
    if (cartCost == null || cartItems == null) return;
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    await cartItemBox.delete(item.productId);
    await cartItemBox.close();
    this.totalPrice = this.totalPrice - totalPrice;
    itemCount = itemCount - item.itemCount;
    cartItems!.deleteItem(item.productId);
    cartCost!.updateCartValue(this.totalPrice, itemCount);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: getCartItem(),
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          List<CartItemModal> cartItems = snapShot.data as List<CartItemModal>;
          Map<String, Widget> data = prepareView(cartItems);
          return cartView(context, screenWidth, data, cartItems);
        } else {
          return WidgetUtils.progressIndicator(context);
        }
      },
    );
  }

  Widget cartView(
    BuildContext context,
    double screenWidth,
    Map<String, Widget> data,
    List<CartItemModal> items,
  ) {
    return Column(
      children: [
        Expanded(
          child: Consumer<CartItemsProvider>(
            builder: (_, items, __) {
              items.initItems(data);
              cartItems = items;
              return cartItems!.items.isEmpty
                  ? emptyCartView(context, screenWidth)
                  : SingleChildScrollView(
                      child: Padding(
                        padding:
                            Utils.calculateScreenLeftRightPaddingWithTop(10),
                        child:
                            Column(children: cartItems!.items.values.toList()),
                      ),
                    );
            },
          ),
        ),
        // Price details and checkout button
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Consumer<CartCostProvider>(
              builder: (_, cartCost, __) {
                cartCost.initValue(totalPrice, itemCount);
                this.cartCost = cartCost;
                return ProductDetailsView(screenWidth, cartCost.cartCost);
              },
            ),
            AddToCartButton(
              screenWidth,
              "Checkout",
              () {
                checkoutView(context, items);
              },
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> generateCheckoutItemsView(List<CartItemModal> cartItems) {
    List<Widget> itemsView = [];
    List<Widget> guessAndWin = [];
    for (CartItemModal item in cartItems) {
      if (item.type == "2")
        guessAndWin.add(CheckoutItemView(item, checkAddressRequired));
      else
        itemsView.add(CheckoutItemView(item, checkAddressRequired));
    }
    guessAndWin.addAll(itemsView);
    return guessAndWin;
  }

  void checkoutView(BuildContext context, List<CartItemModal> cartItems) {
    List<Widget> checkoutItems = generateCheckoutItemsView(cartItems);
    double elementSpacing = MediaQuery.of(context).size.width * 0.05;
    showModalBottomSheet(
      context: context,
      backgroundColor: HexColor("#313030").withOpacity(0.9490196078431372),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          child: ListView(
            children: [
              SizedBox(height: elementSpacing),
              // Title
              Padding(
                padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                child: Text(
                  "What Do You Want To Do With Your Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.subtitle2!.fontFamily,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: elementSpacing),
              Column(children: checkoutItems),
              StatefulBuilder(
                builder: (ctx, addressState) {
                  this.addressState = addressState;
                  return Visibility(
                    visible: isAddressRequired.containsValue(1),
                    child: ProductDetailsView(
                      MediaQuery.of(context).size.width,
                      totalPrice,
                      color: HexColor("#1D1C1C"),
                      productCount: productCount,
                    ),
                    replacement: SizedBox.shrink(),
                  );
                },
              ),
              AddToCartButton(MediaQuery.of(context).size.width, "Checkout", () {
                Fluttertoast.showToast(msg: "Coming soon");
              })
            ],
          ),
        );
      },
    );
  }

  Widget emptyCartView(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OOPS!",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Image.asset(
            "assets/images/cart/empty_cart_icon.png",
            scale: 3,
          ),
          Text("Empty cart.", style: TextStyle(color: Colors.black)),
          Text(
            "Fill it to WIN it",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void checkAddressRequired(String id, int type) {
    if (this.addressState == null)
      return;
    isAddressRequired[id] = type;
  }
}
