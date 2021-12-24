import 'dart:io';

import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/single_product_view.dart';
import 'package:flutter/material.dart';

class FavoriteProductsScreen extends StatelessWidget {
  static const String routeName = "/favorite-products-screen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle("Favorites"),
        automaticallyImplyLeading: false,
        leading: Platform.isIOS ? WidgetUtils.tabBarBackButton(context) : null,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: WebService.fetchFavoritesProducts(),
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            List<SingleProductView> views =
                snapShot.data as List<SingleProductView>;
            if (views.isNotEmpty) {
              return Container(
                width: size.width,
                height: size.height,
                child: Padding(
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
                ),
              );
            } else {
              return Center(
                child: Text("No Product found"),
              );
            }
          } else {
            return Center(
              child: WidgetUtils.progressIndicator(context),
            );
          }
        },
      ),
    );
  }
}
