import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:daily_deals/screens/cart_screen.dart';
import 'package:daily_deals/screens/coupon_screen.dart';
import 'package:daily_deals/screens/notification_screen.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/widgets/app_bar_profile_button.dart';
import 'package:daily_deals/widgets/bottom_navigation_bar_item.dart';
import 'package:daily_deals/widgets/drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class ParentScreen extends StatefulWidget {
  static const routeName = "/parent";

  @override
  State<StatefulWidget> createState() => _ParentScreenState();
}

var scaffoldKey;
PersistentBottomSheetController? controller;

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0;
  bool _containsItem = false;
  Map<int, Widget> _screens = {};
  Map<int, String> _titles = {};

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    setupInteractedMessage();
    _screens = {
      0: HomeScreen(),
      1: CouponScreen(),
      2: NotificationScreen(),
      3: CartScreen()
    };
    _titles = {
      0: "Home",
      1: "My Coupons",
      2: "Notifications",
      3: "Cart",
    };
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _currentIndex = ModalRoute.of(context)!.settings.arguments as int;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bottomHeight = screenWidth * 0.2;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      appBar: _currentIndex != 0
          ? AppBar(
              centerTitle: true,
              title: AppBarTitle(_titles[_currentIndex]!),
              actions: [AppBarProfileButton()],
              backgroundColor: HexColor("#F83615"),
              automaticallyImplyLeading: false,
              systemOverlayStyle:
                  Platform.isIOS ? SystemUiOverlayStyle.dark : null,
            )
          : null,
      drawer: ColorfulSafeArea(child: MyDrawer(screenWidth)),
      bottomNavigationBar: Container(
        color: _currentIndex == 3 && _containsItem
            ? HexColor("#F83615")
            : Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
          child: Container(
            height: bottomHeight,
            color: HexColor("#363636"),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Home",
                  activeIcon: CustomBottomNavigationBar(
                    Icons.home_filled,
                    screenWidth,
                    0.11,
                    "Home",
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/cart/coupon_icon.png",
                    scale: 17.5,
                    color: Colors.white,
                  ),
                  label: "Coupons",
                  activeIcon: CustomBottomNavigationBar(
                    null,
                    screenWidth,
                    0.15,
                    "Coupons",
                    "assets/images/cart/coupon_icon.png",
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: "Notifications",
                  activeIcon: CustomBottomNavigationBar(
                    Icons.notifications,
                    screenWidth,
                    0.21,
                    "Notifications",
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Consumer<CartCostProvider>(
                    builder: (_, cartProvider, iconWidget) {
                      _containsItem = cartProvider.itemCount > 0;
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          iconWidget!,
                          Visibility(
                            visible: _containsItem,
                            child: CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                "${cartProvider.itemCount}",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    child: Icon(Icons.shopping_cart),
                  ),
                  label: "Cart",
                  activeIcon: CustomBottomNavigationBar(
                    Icons.shopping_cart,
                    screenWidth,
                    0.11,
                    "Cart",
                  ),
                ),
              ],
              selectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.white,
              unselectedIconTheme: IconThemeData(color: Colors.white),
              onTap: _onItemTap,
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTap(int index) {
    try {
      if (controller != null) {
        controller!.close();
        controller = null;
      }
    } catch (e) {
      controller = null;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      sound: true,
    );
  }

  void _handleMessage(RemoteMessage message) {
    // try {
    //   setState(() {
    //     _currentIndex = 2;
    //   });
    // } catch (e) {}
  }
}
