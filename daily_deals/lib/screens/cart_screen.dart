import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:daily_deals/providers/cart_item_provider.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/views/cart_address_details_view.dart';
import 'package:daily_deals/views/cart_item_view.dart';
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
  CartCostProvider? cartCost;
  CartItemsProvider? cartItems;

  Future<Map<String, Widget>> getCartItem() async {
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    List<CartItemModal> items = cartItemBox.values.toList();
    await cartItemBox.close();
    return prepareView(items);
  }

  Map<String, Widget> prepareView(List<CartItemModal> items) {
    totalPrice = 0.0;
    productCount = 0;
    Map<String, Widget> data = {};
    productCount = items.length - 1;
    for (int i = 0; i < productCount + 1; i++) {
      CartItemModal m = items[i];
      data[m.productId] = CartCardView(
        items[i],
        deleteItem,
        addPrice,
        minusPrice,
        i != 1 ? true : false,
      );
      if (productCount != i)
        data[m.productId + "d"] =
            SizedBox(width: 300, child: Divider(thickness: 1));
      else
        data[m.productId + "d"] = SizedBox(height: 10);
      totalPrice = totalPrice + (double.parse(m.price) * m.itemCount);
    }
    return data;
  }

  void addPrice(double price) {
    if (cartCost == null) return;
    this.totalPrice = this.totalPrice + price;
    cartCost!.updateCartValue(this.totalPrice, 0, 0);
  }

  void minusPrice(double price) {
    if (cartCost == null) return;
    this.totalPrice = this.totalPrice - price;
    cartCost!.updateCartValue(this.totalPrice, 0, 0);
  }

  void deleteItem(String itemId, double totalPrice) async {
    if (cartCost == null || cartItems == null) return;
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    await cartItemBox.delete(itemId);
    await cartItemBox.close();
    this.totalPrice = this.totalPrice - totalPrice;
    cartCost!.updateCartValue(this.totalPrice, 0, 0);
    cartItems!.deleteItem(itemId);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return FutureBuilder(
      future: getCartItem(),
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          return Column(
            children: [
              Expanded(
                child: Consumer<CartItemsProvider>(
                  builder: (_, items, __) {
                    items.initItems(snapShot.data as Map<String, Widget>);
                    cartItems = items;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: Utils.calculateScreenLeftRightPaddingWithTop(
                            10),
                        child: Column(children: cartItems!.items.values
                            .toList()),
                      ),
                    );
                  },
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Consumer<CartCostProvider>(
                    builder: (_, cartCost, __) {
                      cartCost.initValue(totalPrice);
                      this.cartCost = cartCost;
                      return ProductDetailsView(screenWidth, cartCost.cartCost);
                    },
                  ),
                  AddToCartButton(
                    screenWidth,
                    "Checkout",
                        () {
                      cartFunctionality(context, screenWidth);
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return WidgetUtils.progressIndicator(context);
        }
      },
    );
  }

  void cartFunctionality(BuildContext context, double screenWidth) {
    if (cartItems == null || cartCost == null || cartItems!.items.isEmpty)
      return;

    List<Widget> items = [];
    cartItems!.items.forEach((key, value) {
      if (!key.contains("d")) {
        items.add(value);
        items.add(CartItemView(
          itemType: 0,
          sequenceOfNumbers: [11, 17, 32, 48, 99, 20],
        ));
      }
    });

    double elementSpacing = screenWidth * 0.05;
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
          height: MediaQuery
              .of(context)
              .size
              .height - 100,
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
                    Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .fontFamily,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: elementSpacing),
              // Product details
              Column(
                children: items,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  bottom: 10.0,
                ),
                child: Divider(thickness: 1, color: Colors.grey),
              ),
              CartItemView(itemType: 1),
              CartAddressDetailsView(),
              ProductDetailsView(
                screenWidth,
                totalPrice,
                color: HexColor("#1D1C1C"),
                productCount: productCount,
              ),
              AddToCartButton(screenWidth, "Checkout", () {
                Fluttertoast.showToast(msg: "Coming soon");
              })
            ],
          ),
        );
      },
    );
  }
}
