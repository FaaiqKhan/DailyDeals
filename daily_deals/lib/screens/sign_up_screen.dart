import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/screens/sign_in_screen.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/screen_title.dart';
import 'package:daily_deals/widgets/sign_up_form.dart';
import 'package:daily_deals/widgets/social_button.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "/sign-up";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsetsGeometry pagePadding =
        Utils.calculateScreenLeftRightPadding(screenWidth);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ColorfulSafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left pattern
            ScreenTitle("Sign Up", screenWidth),
            Expanded(
              child: Padding(
                padding: pagePadding,
                child: SingleChildScrollView(
                  child: SignUpForm(screenWidth),
                ),
              ),
            ),
            Column(
              children: [
                // Or text
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Text(
                    "----- Or -----",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                // Social button
                Padding(
                  padding: pagePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Facebook button
                      SocialButton(context: context, identifier: 0),
                      // Google button
                      SocialButton(context: context, identifier: 1),
                    ],
                  ),
                ),
                // Already have account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account?",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1!.fontFamily,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName),
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.headline6!.fontFamily,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    )
                  ],
                ),
                // Bottom pattern
                Container(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    "assets/images/bottom_side_pattern.png",
                    width: Utils.calculatePatternWidth(screenWidth),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
