import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class SignInUpScreen extends StatelessWidget {
  static const String routeName = "/sign-in-up";
  final String title = "Let's Get Started";
  final String subTitle =
      "Just sign in or create an account. Some exciting deals are waiting for you!";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: Utils.calculateScreenLeftRightPadding(screenWidth),
            child: Column(
              children: [
                SizedBox(
                  height: pageHeight(screenHeight),
                ),
                Text(title, style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                AppButton(
                  context: context,
                  text: "Sign In",
                  isFilled: false,
                  functionality: () {
                    Navigator.of(context).pushNamed(SignInScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 11,
                ),
                // Sign Up button
                AppButton(
                  context: context,
                  text: "Sign Up",
                  functionality: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Image.asset(
                  "assets/images/left_side_pattern.png",
                  height: Utils.calculatePatternHeight(screenWidth),
                ),
              ),
              Container(
                child: Image.asset(
                  "assets/images/right_side_pattern.png",
                  height: Utils.calculatePatternHeight(screenWidth),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  double pageHeight(double screenHeight) {
    return screenHeight - (screenHeight * 0.94);
  }
}
