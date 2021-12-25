import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/screens/draws_screen.dart';
import 'package:daily_deals/screens/help_screen.dart';
import 'package:daily_deals/screens/sign_in_up_screen.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/screens/products_showcase_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final double screenWidth;

  MyDrawer(this.screenWidth);

  @override
  Widget build(BuildContext context) {
    double drawerIconsDistance = 25.0;
    double elementHeight = screenWidth * 0.05;
    double titleElementSpacing = screenWidth * 0.1;
    double topSpacing = screenWidth * 0.15;
    if (Scaffold.of(context).appBarMaxHeight != null)
      topSpacing = Scaffold.of(context).appBarMaxHeight! * 0.75;

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: topSpacing),
        height: screenWidth * 1.38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          color: HexColor("#F83615"),
        ),
        child: Drawer(
          elevation: 0.0,
          child: ListView(
            padding: EdgeInsets.only(
              left: titleElementSpacing,
              top: titleElementSpacing,
            ),
            children: [
              // Title
              Text(
                "Profile Setting",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: titleElementSpacing),
              // Language
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/drawer/language_icon.png",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: drawerIconsDistance),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 15.0),
                      // English
                      Container(
                        color: Colors.white.withOpacity(0.2),
                        width: screenWidth * 0.33,
                        height: screenWidth * 0.067,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "English",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Image.asset(
                              "assets/images/drawer/united_kingdom_icon.png",
                              scale: 1.2,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Arabic
                      Container(
                        color: Colors.white.withOpacity(0.2),
                        width: screenWidth * 0.33,
                        height: screenWidth * 0.067,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Arabic",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Image.asset(
                              "assets/images/drawer/united_arab_emirates_icon.png",
                              scale: 1.2,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: elementHeight),
              // Draws
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, DrawsScreen.routeName);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/drawer/draws_icon.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: drawerIconsDistance),
                    Text(
                      "Draws",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: elementHeight),
              // Products
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, ProductsShowCaseScreen.routeName);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/drawer/products_icon.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: drawerIconsDistance),
                    Text(
                      "Products",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: elementHeight),
              // Help
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, HelpScreen.routeName);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/drawer/help_icon.png",
                      width: 30,
                      height: 30,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    SizedBox(width: drawerIconsDistance),
                    Text(
                      "Help",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: elementHeight),
              // Log out
              GestureDetector(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  var cartItemBox =
                      await Hive.openBox<CartItemModal>('cartItem');
                  await preferences.clear();
                  await cartItemBox.clear();
                  await cartItemBox.close();
                  await FirebaseAuth.instance.signOut();
                  Utils.homeDataModal = null;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInUpScreen.routeName,
                    (route) => false,
                    arguments: true,
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/drawer/logout_icon.png",
                      width: 30,
                      height: 30,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    SizedBox(width: drawerIconsDistance),
                    Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
