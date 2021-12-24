import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/screens/enter_phone_number_screen.dart';
import 'package:daily_deals/screens/sign_up_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/constants.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/widgets/screen_title.dart';
import 'package:daily_deals/widgets/sign_in_form.dart';
import 'package:daily_deals/widgets/social_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'parent_screen.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/sign-in";

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left pattern
            ScreenTitle("Sign In", screenWidth),
            Expanded(
              child: Padding(
                padding: pagePadding,
                child: SingleChildScrollView(
                  child: SignInForm(),
                ),
              ),
            ),
            // Or text
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
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
                  SocialButton(
                    context: context,
                    iconPath: "assets/images/facebook_f.png",
                    text: "Facebook",
                    color: HexColor("#3C5A99"),
                    functionality: () async {
                      await WebService.signInWithFacebook();
                    },
                  ),
                  // Google button
                  SocialButton(
                    context: context,
                    iconPath: "assets/images/google_g.png",
                    text: "Google",
                    color: HexColor("#EC462D"),
                    functionality: () async {
                      WidgetUtils.showLoaderDialog(context, "Signing In...");
                      bool val = await WebService.signInWithGoogle();
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String? phoneNumber =
                          preferences.getString(Constants.PHONE_NUMBER);
                      Navigator.of(context).pop();
                      if (val) {
                        if (phoneNumber == null || phoneNumber.isEmpty) {
                          Navigator.pushReplacementNamed(
                              context, EnterPhoneNumberScreen.routeName);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context,
                              ParentScreen.routeName, (route) => false);
                        }
                      } else {
                        WidgetUtils.showToast(
                          "Sign-In failed! try again later",
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            // Don't have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account?",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                // Sign up button
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, SignUpScreen.routeName),
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.headline6!.fontFamily,
                      color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
