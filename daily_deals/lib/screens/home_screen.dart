import 'dart:io';

import 'package:daily_deals/modals/home_data_modal.dart';
import 'package:daily_deals/screens/winners_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/winners_view.dart';
import 'package:daily_deals/widgets/closing_soon_slider.dart';
import 'package:daily_deals/widgets/current_deals_slider.dart';
import 'package:daily_deals/widgets/guess_and_win_slider.dart';
import 'package:daily_deals/widgets/home_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double elementsDistance = 10;
  bool products = true;
  bool closingSoon = false;
  bool todayDeal = false;
  bool winner = false;

  Widget buttonContainer(String title, bool isSelected) {
    Color decorColor =
        isSelected ? Theme.of(context).primaryColor : HexColor("#EAEAEA");
    Color textColor = isSelected ? Colors.white : HexColor("#C6BFBF");
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 12),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: decorColor,
        border: Border.all(color: decorColor),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }

  Widget topBarWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      color: HexColor("#EAEAEA"),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 5.0),
          Flexible(
            child: GestureDetector(
              onTap: () => setState(() {
                products = true;
                closingSoon = false;
                todayDeal = false;
                winner = false;
              }),
              child: buttonContainer("Products", products),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => setState(() {
                products = false;
                closingSoon = true;
                todayDeal = false;
                winner = false;
              }),
              child: buttonContainer("Closing Soon", closingSoon),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => setState(() {
                products = false;
                closingSoon = false;
                todayDeal = true;
                winner = false;
              }),
              child: buttonContainer("Today's Deal", todayDeal),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => setState(() {
                products = false;
                closingSoon = false;
                todayDeal = false;
                winner = true;
              }),
              child: buttonContainer("Winner", winner),
            ),
          ),
          SizedBox(width: 5.0),
        ],
      ),
    );
  }

  Widget showSelectedView(double screenWidth) {
    if (closingSoon) {
      return ClosingSoonSlider(
        Utils.homeDataModal!.closingSoon!,
        scrollDirection: Axis.vertical,
      );
    } else if (todayDeal) {
      return CurrentDealsSlider(
        Utils.homeDataModal!.currentDeals!,
        scrollDirection: Axis.vertical,
      );
    } else if (winner) {
      return WinnersScreen(
        screenWidth,
        Utils.homeDataModal!.winners,
      );
    } else {
      return Column(
        children: [
          // Slider
          HomeSlider(Utils.homeDataModal!.slider!),
          // Other components
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClosingSoonSlider(Utils.homeDataModal!.closingSoon!),
                SizedBox(height: elementsDistance),
                CurrentDealsSlider(Utils.homeDataModal!.currentDeals!),
                SizedBox(height: elementsDistance),
                GuessAndWinSlider(Utils.homeDataModal!.guessAndWin!),
                SizedBox(height: elementsDistance),
                Winners(Utils.homeDataModal!.winners!),
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsetsGeometry pagePadding =
        Utils.calculateScreenLeftRightPadding(screenWidth);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: Platform.isIOS ? SystemUiOverlayStyle.dark : null,
        actions: [
          Padding(
            padding: pagePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Profile icon
                GestureDetector(
                  child: Image.asset("assets/images/person_icon.png"),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
                SizedBox(width: 20),
                // Favorite icon
                GestureDetector(
                  child: Image.asset("assets/images/favorite_icon.png"),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          topBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: WebService.fetchData(),
                builder: (ctx, snapShot) {
                  if (snapShot.hasData) {
                    Utils.homeDataModal = snapShot.data as HomeDataModal;
                    return showSelectedView(screenWidth);
                  } else {
                    return Container(
                      height: screenWidth,
                      child: WidgetUtils.progressIndicator(context),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
