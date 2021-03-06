import 'dart:io';

import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/common/utilities.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/product_details_view.dart';
import 'package:daily_deals/widgets/add_to_cart_button.dart';
import 'package:daily_deals/widgets/add_to_favorites.dart';
import 'package:daily_deals/widgets/closing_timer.dart';
import 'package:daily_deals/widgets/guess_and_sequence.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = "/product-details";

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double screenWidth = 0, sizeOfProduct = 0, countContainerWidth = 0;
  double elementSpacing = 0, countContainerHeight = 0;
  String? productId;
  bool isPrizeDetailsSelected = true;
  int _productCount = 1;
  DetailedProductModal? _detailedProductModel;
  double productPrice = 0.0;
  List<Widget> sequenceAdderView = [];
  Map<dynamic, dynamic> _mySequence = {};
  bool showSequence = false;
  CartItemModal? item;
  bool isGenerated = false;
  bool isExpired = false;

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
  void didChangeDependencies() {
    if (screenWidth == 0) {
      screenWidth = MediaQuery.of(context).size.width;
      sizeOfProduct = screenWidth * 0.25;
      countContainerWidth = screenWidth * 0.35;
      countContainerHeight = screenWidth * 0.12;
      elementSpacing = screenWidth * 0.04;
      try {
        productId = ModalRoute.of(context)!.settings.arguments as String;
      } catch (error) {
        item = ModalRoute.of(context)!.settings.arguments as CartItemModal;
      }
    }
    super.didChangeDependencies();
  }

  Future<DetailedProductModal?> getFutureModel() {
    if (_detailedProductModel == null) {
      return WebService.fetchProductDetails(productId ?? item!.productId);
    }
    return Future.value(_detailedProductModel);
  }

  Widget header(double screenWidth, DetailedProductModal productModel) {
    String topRightImage = isPrizeDetailsSelected
        ? productModel.productImage!
        : productModel.prizeImage!;
    return Container(
      width: screenWidth,
      child: Stack(
        children: [
          Visibility(
            visible: isPrizeDetailsSelected,
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(top: 0.0),
              alignment: Alignment.bottomCenter,
              child: Image.network(
                productModel.prizeImage!,
                scale: 3.3,
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
            ),
            replacement: Container(
              padding: const EdgeInsets.only(top: 30.0),
              alignment: Alignment.center,
              child: Image.network(
                productModel.productImage!,
                scale: 3.3,
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
                          productModel.title ?? "",
                        );
                      },
                      child: Opacity(
                        opacity: 0.6509803921568628,
                        child: Icon(Icons.share_outlined, size: 28),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    AddToFavorites(productModel.dealId!, false),
                  ],
                ),
                // Top right image
                Container(
                  width: sizeOfProduct,
                  height: sizeOfProduct,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(topRightImage, fit: BoxFit.fill,
                        loadingBuilder: (ctx, widget, progress) {
                      if (progress == null) {
                        return widget;
                      } else {
                        return WidgetUtils.progressIndicator(context);
                      }
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              isPrizeDetailsSelected = true;
              showSequence = false;
            }),
            child: Container(
              alignment: Alignment.center,
              color: isPrizeDetailsSelected
                  ? HexColor("#F83615")
                  : HexColor("#444343"),
              height: screenWidth * 0.11,
              child: Text(
                "Prize Details",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              isPrizeDetailsSelected = false;
              showSequence = false;
            }),
            child: Container(
              alignment: Alignment.center,
              color: isPrizeDetailsSelected
                  ? HexColor("#444343")
                  : HexColor("#F83615"),
              height: screenWidth * 0.11,
              child: Text(
                "Product Details",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget productCounts() {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle("Product Details"),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        leading: Platform.isIOS ? WidgetUtils.tabBarBackButton(context) : null,
      ),
      backgroundColor: HexColor("#FCF4F4"),
      body: FutureBuilder(
        future: getFutureModel(),
        builder: (ctx, snapShot) {
          if (!snapShot.hasData) {
            return WidgetUtils.progressIndicator(context);
          }
          prepareModal(snapShot);
          int timeInMillis = _detailedProductModel!.timeStamp * 1000;
          var dateTime = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
          if (dateTime.isBefore(DateTime.now())) {
            isExpired = true;
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Main image with share and favorites icons
                  header(screenWidth, _detailedProductModel!),
                  SizedBox(height: 10.0),
                  Column(
                    children: [
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
                            margin: const EdgeInsets.only(top: 30),
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
                                productCounts(),
                                SizedBox(height: elementSpacing),
                                // Buttons
                                buttons(),
                                SizedBox(height: elementSpacing),
                                // Details
                                Visibility(
                                  visible: showSequence,
                                  child: Column(children: sequenceAdderView),
                                  replacement: productDetails(
                                    isPrizeDetailsSelected,
                                    _detailedProductModel!,
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ProductDetailsView(
                                      screenWidth,
                                      _productCount * productPrice,
                                    ),
                                    addToCart(screenWidth, isExpired),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Timer container
                          Container(
                            width: screenWidth * 0.7,
                            child: ClosingTimer(
                              _detailedProductModel!.timeStamp,
                              useShrinkForm: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productDetails(bool isPrizeDetails, DetailedProductModal model) {
    String? title = isPrizeDetails ? model.prizeName : model.title;
    String? description =
        isPrizeDetails ? model.priceDescription : model.description;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isPrizeDetailsSelected,
            child: Text(
              "Get a change To win",
              style: TextStyle(color: HexColor("#303030"), fontSize: 17),
            ),
          ),
          Text(
            title ?? "",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
              color: HexColor("#303030"),
              fontSize: 17,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth),
            child: Text(
              description ?? "",
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

  bool validateProductType() {
    if (_detailedProductModel!.type == "2" && _mySequence.isEmpty) {
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

  void prepareModal(var snapShot) {
    _detailedProductModel = snapShot.data as DetailedProductModal;
    if (!isGenerated) {
      productPrice = double.parse(_detailedProductModel!.price!);
      if (productId == null) {
        _productCount = _productCount + item!.itemCount;
        productPrice = productPrice + double.parse(item!.price);
        for (int i = 0; i < item!.itemCount; i++) {
          sequenceAdderView.add(
            GuessAndWinSequence(
              _productCount,
              saveSequence,
              preDefinedSequence: item!.mySequence.values.elementAt(i),
            ),
          );
          _mySequence[i + 1] = item!.mySequence.values.elementAt(i);
        }
        sequenceAdderView.add(GuessAndWinSequence(_productCount, saveSequence));
        showSequence = true;
      } else {
        sequenceAdderView.add(GuessAndWinSequence(1, saveSequence));
      }
      isGenerated = true;
    }
  }

  Widget addToCart(double screenWidth, bool isExpired) {
    return AddToCartButton(screenWidth, "Add to cart", () async {
      if (isExpired) {
        WidgetUtils.showToast("Deal Expired. Please look for other deals");
        return;
      }
      bool canBuy = await WebService.checkUserProducts(productId);
      if (canBuy) {
        bool proceedToCheckout = true;
        if (_detailedProductModel!.type == "2") {
          setState(() {
            showSequence = true;
          });
        }
        if (showSequence && _mySequence.length != sequenceAdderView.length) {
          Fluttertoast.showToast(
            msg: "Please complete your sequences to proceed towards checkout",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
          proceedToCheckout = false;
        }
        if (proceedToCheckout || _detailedProductModel!.type != "2") {
          bool isValid = validateProductType();
          if (isValid) {
            await Utilities().populateData(
              context,
              _detailedProductModel!,
              _productCount,
              _mySequence,
              productPrice,
            );
            Fluttertoast.showToast(
              msg: "Product added into cart",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
            );
            Utils.moveToNextScreenAfterCertainTime(2, () {
              Fluttertoast.cancel();
              Navigator.pushNamedAndRemoveUntil(
                context,
                ParentScreen.routeName,
                (route) => false,
                arguments: 3,
              );
            });
          }
        }
      }
    });
  }
}
