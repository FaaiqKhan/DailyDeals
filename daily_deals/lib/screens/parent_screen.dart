import 'package:daily_deals/screens/cart_screen.dart';
import 'package:daily_deals/screens/coupon_screen.dart';
import 'package:daily_deals/screens/notification_screen.dart';
import 'package:daily_deals/widgets/bottom_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class ParentScreen extends StatefulWidget {
  static const routeName = "/parent";

  @override
  State<StatefulWidget> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0;
  List<Widget> _screens = [];

  @override
  void initState() {
    _screens = [
      HomeScreen(),
      CouponScreen(),
      NotificationScreen(),
      CartScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0)),
        child: Container(
          height: 100,
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black54),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Home",
                  activeIcon: CustomBottomNavigationBar(
                    Icons.home_filled,
                    "Home",
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/coupon_icon.png"),
                  label: "Coupons",
                  activeIcon: CustomBottomNavigationBar(
                    null,
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
