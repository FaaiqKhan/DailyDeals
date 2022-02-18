import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/common/utilities.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class PriceDetailsAndAddToCartButtons extends StatelessWidget {
  final ProductModal modal;
  final int identifier;

  PriceDetailsAndAddToCartButtons(this.modal, this.identifier);

  @override
  Widget build(BuildContext context) {
    double fontSize = 11.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProductDetails.routeName,
              arguments: modal.dealId,
            );
          },
          child: Text(
            "Prize Details",
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: fontSize),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              HexColor("#303030"),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (identifier == 0) {
              WidgetUtils.showLoaderDialog(context, "Adding product into cart");
              DetailedProductModal? productModal =
                  await WebService.fetchProductDetails(modal.dealId!);
              if (productModal != null) {
                await Utilities().populateData(
                  context,
                  productModal,
                  1,
                  {},
                  double.parse(productModal.price!),
                );
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
              Navigator.of(context).pop();
            } else if (identifier == 1) {
              Navigator.pushNamed(
                context,
                ProductDetails.routeName,
                arguments: modal.dealId,
              );
            }
          },
          child: Text(
            "Add to Cart",
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: fontSize),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              HexColor("#DA2B0E"),
            ),
          ),
        ),
      ],
    );
  }
}
