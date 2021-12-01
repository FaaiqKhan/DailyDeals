import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = "/product-details";

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double screenWidth = 0, sizeOfProduct = 0, countContainerWidth = 0;
  double elementSpacing = 0, countContainerHeight = 0;
  String productId = "0";
  bool isPriceDetailsSelected = true;
  int productCount = 1;
  DetailedProductModal? _modal;
  double productPrice = 0.0;

  @override
  void didChangeDependencies() {
    if (screenWidth == 0) {
      screenWidth = MediaQuery.of(context).size.width;
      sizeOfProduct = screenWidth * 0.25;
      countContainerWidth = screenWidth * 0.35;
      countContainerHeight = screenWidth * 0.12;
      elementSpacing = screenWidth * 0.04;
      productId = ModalRoute.of(context)!.settings.arguments as String;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle("Product Details"),
        leading: Container(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: HexColor("#FCF4F4"),
      body: FutureBuilder(
        future: _modal == null
            ? WebService.fetchProductDetails(productId)
            : Future.value(_modal),
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            _modal = snapShot.data as DetailedProductModal;
            productPrice = double.parse(_modal!.price!);
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Banner image with share and favorites icons
                  Container(
                    width: screenWidth,
                    child: Stack(
                      children: [
                        Image.network(
                          isPriceDetailsSelected
                              ? _modal!.bannerImage!
                              : _modal!.productImage!,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (ctx, widget, progress) {
                            if (progress == null) {
                              return widget;
                            } else {
                              return Container(
                                width: screenWidth,
                                height: screenWidth / 2,
                                child: WidgetUtils.progressIndicator(context),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Top features
                              Column(
                                children: [
                                  // Shared and favorite icons
                                  Opacity(
                                    opacity: 0.6509803921568628,
                                    child: Icon(Icons.share_outlined, size: 28),
                                  ),
                                  SizedBox(height: screenWidth * 0.04),
                                  Opacity(
                                    opacity: 0.6509803921568628,
                                    child: Icon(
                                      Icons.favorite_outline_outlined,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                              // Top right image
                              Container(
                                width: sizeOfProduct,
                                height: sizeOfProduct,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      isPriceDetailsSelected
                                          ? _modal!.productImage!
                                          : _modal!.bannerImage!,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (ctx, widget, progress) {
                                    if (progress == null) {
                                      return widget;
                                    } else {
                                      return WidgetUtils.progressIndicator(
                                          context);
                                    }
                                  }),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Timer image
                  Opacity(
                    opacity: 0.25882352941176473,
                    child: Image.asset(
                      'assets/images/clock_icon.png',
                      scale: 10,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Watch tag line
                  Text(
                    "Closing in",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                      color: HexColor("#5F5C5C"),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: screenWidth * 0.1),
                            // Product count
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    if (productCount > 1) productCount--;
                                  }),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Container(
                                  alignment: Alignment.center,
                                  width: countContainerWidth,
                                  height: countContainerHeight,
                                  decoration: BoxDecoration(
                                    color: HexColor("#303030"),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    productCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                InkWell(
                                  onTap: () => setState(() {
                                    if (productCount < 3) productCount++;
                                  }),
                                  child: Icon(Icons.add, color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(height: elementSpacing),
                            // Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      isPriceDetailsSelected = true;
                                    }),
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: isPriceDetailsSelected
                                          ? HexColor("#F83615")
                                          : HexColor("#444343"),
                                      height: screenWidth * 0.11,
                                      child: Text(
                                        "Price Details",
                                        style: TextStyle(
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .fontFamily,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      isPriceDetailsSelected = false;
                                    }),
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: isPriceDetailsSelected
                                          ? HexColor("#444343")
                                          : HexColor("#F83615"),
                                      height: screenWidth * 0.11,
                                      child: Text(
                                        "Product Details",
                                        style: TextStyle(
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .fontFamily,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: elementSpacing),
                            // Details
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Get a change To win",
                                    style: TextStyle(
                                      color: HexColor("#303030"),
                                      fontSize: 17,
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: screenWidth),
                                    child: Text(
                                      "2021 Mercedes AMZ-G63: UAE Golden Jubliee Edition",
                                      style: TextStyle(
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .fontFamily,
                                        color: HexColor("#303030"),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: screenWidth),
                                    child: Text(
                                      isPriceDetailsSelected
                                          ? _modal!.priceDescription!
                                          : _modal!.description!,
                                      style: TextStyle(
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .fontFamily,
                                        color: HexColor("#303030"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ProductDetailsView(
                                  screenWidth,
                                  productCount * productPrice,
                                ),
                                AddToCartButton(
                                  screenWidth,
                                  "Add to cart",
                                  () async {
                                    CartItemModal cartModal = CartItemModal(
                                      _modal!.dealId!,
                                      _modal!.productImage!,
                                      _modal!.price!,
                                      _modal!.description!,
                                      productCount,
                                      _modal!.price!,
                                    );
                                    var cartItemBox =
                                        await Hive.openBox<CartItemModal>(
                                            'cartItem');
                                    await cartItemBox.put(
                                        _modal!.dealId, cartModal);
                                    await cartItemBox.close();
                                    Fluttertoast.showToast(
                                      msg: "Product added into cart",
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG,
                                    );
                                    Utils.moveToNextScreenAfterCertainTime(3,
                                        () {
                                      Fluttertoast.cancel();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        ParentScreen.routeName,
                                        (route) => false,
                                        arguments: 3,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Timer container
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.7,
                        child: ClosingTimer(
                          Duration(
                              days: 6, hours: 16, minutes: 26, seconds: 46),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return WidgetUtils.progressIndicator(context);
          }
        },
      ),
    );
  }
}
