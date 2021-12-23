import 'dart:io';

import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/single_product_view.dart';
import 'package:flutter/material.dart';

class FavoriteProductsScreen extends StatelessWidget {
  static const String routeName = "/favorite-products-screen";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: Utils.calculateScreenLeftRightPadding(screenWidth),
        child: FutureBuilder(
          future: WebService.fetchFavoritesProducts(),
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              List<SingleProductView> data =
                  snapShot.data as List<SingleProductView>;
              if (data.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(children: data),
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
      ),
    );
  }
}
