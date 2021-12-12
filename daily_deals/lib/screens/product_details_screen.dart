import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:daily_deals/widgets/guess_and_sequence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

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
  int _productCount = 1;
  DetailedProductModal? _modal;
  double productPrice = 0.0;
  List<Widget> sequenceAdderView = [];
  Map<dynamic, dynamic> _mySequence = {};
  bool showSequence = false;

  void saveSequence(int sequenceKey, List<String> sequence) {
    if (sequence.length == 6) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Your sequence is successfully submitted",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      _mySequence[sequenceKey] = sequence;
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Complete your sequence first",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  void initState() {
    sequenceAdderView.add(GuessAndWinSequence(1, saveSequence));
    super.initState();
  }

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
        automaticallyImplyLeading: false,
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
                        Visibility(
                          visible: isPriceDetailsSelected,
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.only(top: 30.0),
                            alignment: Alignment.center,
                            child: Image.network(
                              _modal!.bannerImages.first,
                              scale: 3.3,
                              loadingBuilder: (ctx, widget, progress) {
                                if (progress == null) {
                                  return widget;
                                } else {
                                  return Container(
                                    width: screenWidth,
                                    height: screenWidth / 2,
                                    child:
                                        WidgetUtils.progressIndicator(context),
                                  );
                                }
                              },
                            ),
                          ),
                          replacement: Container(
                            padding: const EdgeInsets.only(top: 30.0),
                            alignment: Alignment.center,
                            child: Image.network(
                              _modal!.productImage!,
                              scale: 3.3,
                              loadingBuilder: (ctx, widget, progress) {
                                if (progress == null) {
                                  return widget;
                                } else {
                                  return Container(
                                    width: screenWidth,
                                    height: screenWidth / 2,
                                    child:
                                        WidgetUtils.progressIndicator(context),
                                  );
                                }
                              },
                            ),
                          ),
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
                                  GestureDetector(
                                    onTap: () {
                                      Utils.shareProduct(
                                        'https://flutter.dev/',
                                        _modal!.title ?? "",
                                      );
                                    },
                                    child: Opacity(
                                      opacity: 0.6509803921568628,
                                      child:
                                          Icon(Icons.share_outlined, size: 28),
                                    ),
                                  ),
                                  SizedBox(height: screenWidth * 0.04),
                                  Opacity(
                                    opacity: 0.6509803921568628,
                                    child: GestureDetector(
                                      child: Image.asset(
                                        "assets/images/favorite_icon.png",
                                        scale: WidgetUtils.iconScale,
                                      ),
                                      onTap: () {},
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
                                          : _modal!.bannerImages.first,
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
                    child:
                        Image.asset('assets/images/clock_icon.png', scale: 10),
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
                                    if (_productCount > 1) {
                                      _mySequence.remove(_productCount);
                                      _productCount--;
                                      sequenceAdderView.removeLast();
                                    }
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
                                    _productCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                InkWell(
                                  onTap: () => setState(
                                    () {
                                      if (_productCount < 3) {
                                        _productCount++;
                                        sequenceAdderView.add(
                                          GuessAndWinSequence(
                                            _productCount,
                                            saveSequence,
                                          ),
                                        );
                                      } else {
                                        WidgetUtils.showCountAlert(context);
                                      }
                                    },
                                  ),
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
                                      showSequence = false;
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
                                      showSequence = false;
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
                            Visibility(
                              visible: showSequence,
                              child: Column(children: sequenceAdderView),
                              replacement: productDetails(),
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ProductDetailsView(
                                  screenWidth,
                                  _productCount * productPrice,
                                ),
                                AddToCartButton(
                                  screenWidth,
                                  "Add to cart",
                                  () async {
                                    bool proceedToCheckout = true;
                                    if (_modal!.type == "2") {
                                      setState(() {
                                        showSequence = true;
                                      });
                                    }
                                    if (showSequence &&
                                        _mySequence.length !=
                                            sequenceAdderView.length) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Please complete your sequences to proceed towards checkout",
                                        gravity: ToastGravity.BOTTOM,
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                      proceedToCheckout = false;
                                    }
                                    if (proceedToCheckout ||
                                        _modal!.type != "2") {
                                      bool isValid = validateProductType();
                                      if (isValid) {
                                        await populateData();
                                        Fluttertoast.showToast(
                                          msg: "Product added into cart",
                                          gravity: ToastGravity.BOTTOM,
                                          toastLength: Toast.LENGTH_LONG,
                                        );
                                        Utils.moveToNextScreenAfterCertainTime(
                                          2,
                                          () {
                                            Fluttertoast.cancel();
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              ParentScreen.routeName,
                                              (route) => false,
                                              arguments: 3,
                                            );
                                          },
                                        );
                                      }
                                    }
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

  Widget productDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
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
            constraints: BoxConstraints(maxWidth: screenWidth),
            child: Text(
              _modal!.title!,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: HexColor("#303030"),
                fontSize: 17,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth),
            child: Text(
              isPriceDetailsSelected
                  ? _modal!.priceDescription ?? ""
                  : _modal!.description!,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                color: HexColor("#303030"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> populateData() async {
    CartItemModal cartModal = CartItemModal(
      _modal!.dealId!,
      _modal!.productImage!,
      _modal!.price!,
      _modal!.description!,
      _productCount,
      _modal!.price!,
      _modal!.type!,
      _mySequence,
    );
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    await cartItemBox.put(_modal!.dealId, cartModal);
    await cartItemBox.close();
    Provider.of<CartCostProvider>(context, listen: false).updateCartValue(
      productPrice * _productCount,
      _productCount,
    );
  }

  bool validateProductType() {
    if (_modal!.type == "2" && _mySequence.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please select your sequence",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    } else {
      return true;
    }
  }
}
