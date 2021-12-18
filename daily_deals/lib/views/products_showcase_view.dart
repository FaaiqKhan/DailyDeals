import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/single_product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsShowCaseView extends StatelessWidget {
  final double screenWidth;

  ProductsShowCaseView(this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: WebService.fetchProducts(),
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            List<SingleProductView> views =
                snapShot.data as List<SingleProductView>;
            if (views.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.extent(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  maxCrossAxisExtent: 200,
                  physics: ScrollPhysics(),
                  children: views,
                ),
              );
            } else {
              return Container(
                child: Text("All sold out..."),
              );
            }
          } else {
            return Container(
              height: screenWidth,
              child: WidgetUtils.progressIndicator(context),
            );
          }
        });
  }
}
