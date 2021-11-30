import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/views/cart_address_details_view.dart';
import 'package:daily_deals/views/cart_item_view.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0.0;

  Future<List<CartItemModal>> getCartItem() async {
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    List<CartItemModal> items = cartItemBox.values.toList();
    await cartItemBox.close();
    return items;
  }

  List<Widget> prepareView(List<CartItemModal> items) {
    double price = 0.0;
    List<Widget> data = [];
    int itemCount = items.length - 1;
    for (int i = 0; i < itemCount + 1; i++) {
      data.add(
        CartCardView(
          items[i],
          deleteItem,
          addPrice,
          minusPrice,
          i != 1 ? true : false,
        ),
      );
      if (itemCount != i)
        data.add(SizedBox(width: 300, child: Divider(thickness: 1)));
      else
        data.add(SizedBox(height: 10));
      price = price + double.parse(items[i].price);
    }
    if (totalPrice == 0.0 && items.isNotEmpty)
      totalPrice = price;
    else
      totalPrice = 0.0;
    return data;
  }

  void addPrice(double price) {
    setState(() {
      this.totalPrice = this.totalPrice + price;
    });
  }

  void minusPrice(double price) {
    setState(() {
      this.totalPrice = this.totalPrice - price;
    });
  }

  void deleteItem(String itemId, double totalPrice) async {
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    await cartItemBox.delete(itemId);
    await cartItemBox.close();
    setState(() {
      this.totalPrice = this.totalPrice - totalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double elementSpacing = screenWidth * 0.05;

    return FutureBuilder(
      future: getCartItem(),
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          List<Widget> dataView =
              prepareView(snapShot.data as List<CartItemModal>);
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: Utils.calculateScreenLeftRightPaddingWithTop(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: dataView,
                    ),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ProductDetailsView(screenWidth, totalPrice, "3", "2"),
                  AddToCartButton(
                    screenWidth,
                    "Checkout",
                    () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: HexColor("#313030"),
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        builder: (ctx) {
                          return Container(
                            height: screenHeight - 100,
                            child: ListView(
                              children: [
                                SizedBox(height: elementSpacing),
                                // Title
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 70.0, right: 70.0),
                                  child: Text(
                                    "What Do You Want To Do With Your Products",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: Theme.of(context)
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
                                CartItemView(
                                  itemType: 0,
                                  sequenceOfNumbers: [11, 17, 32, 48, 99, 20],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    bottom: 10.0,
                                  ),
                                  child:
                                      Divider(thickness: 1, color: Colors.grey),
                                ),
                                CartItemView(itemType: 1),
                                CartAddressDetailsView(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
