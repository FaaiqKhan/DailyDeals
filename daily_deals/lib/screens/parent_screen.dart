import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/screens/cart_screen.dart';
import 'package:daily_deals/screens/coupon_screen.dart';
import 'package:daily_deals/screens/notification_screen.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/widgets/app_bar_profile_button.dart';
import 'package:daily_deals/widgets/bottom_navigation_bar_item.dart';
import 'package:daily_deals/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'home_screen.dart';

class ParentScreen extends StatefulWidget {
  static const routeName = "/parent";

  @override
  State<StatefulWidget> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0;
  Map<int, Widget> _screens = {};
  Map<int, String> _titles = {};

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bottomHeight = screenWidth * 0.2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      appBar: _currentIndex != 0
          ? AppBar(
              title: AppBarTitle(_titles[_currentIndex]!),
              actions: [AppBarProfileButton()],
              backgroundColor: HexColor("#F83615"),
              leading: Container(),
            )
          : null,
      drawer: ColorfulSafeArea(
        child: MyDrawer(screenWidth),
      ),
      bottomNavigationBar: Container(
        color: _currentIndex == 3 ? HexColor("#F83615") : Colors.white,
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
                    "assets/images/coupon_icon.png",
                    scale: 15,
                    color: Colors.white,
                  ),
                  label: "Coupons",
                  activeIcon: CustomBottomNavigationBar(
                    null,
                    screenWidth,
                    0.15,
                    "Coupons",
                    null,
                    "assets/images/coupon_icon.png",
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
                  icon: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Icon(Icons.shopping_cart),
                      CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        child: Text("1"),
                      )
                    ],
                  ),
                  label: "Cart",
                  activeIcon: CustomBottomNavigationBar(
                    Icons.shopping_cart,
                    screenWidth,
                    0.11,
                    "Cart",
                    2,
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
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
