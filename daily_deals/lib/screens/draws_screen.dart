import 'dart:io';

import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/widgets/draws.dart';
import 'package:flutter/material.dart';

class DrawsScreen extends StatelessWidget {
  static const String routeName = "/draws-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              "assets/images/drawer/draws_icon.png",
              color: Colors.white,
            ),
            AppBarTitle("Draws"),
          ],
        ),
        automaticallyImplyLeading: false,
        leading: Platform.isIOS ? WidgetUtils.tabBarBackButton(context) : null,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Draws(),
            ],
          ),
        ),
      ),
    );
  }

}