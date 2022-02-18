import 'package:daily_deals/screens/enter_phone_number_screen.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/constants.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialButton extends StatelessWidget {
  final BuildContext? context;
  final int identifier;

  SocialButton({
    required this.context,
    this.identifier = 0,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: calculateSocialButtonWidth(screenWidth),
      height: Utils.calculateButtonHeight(screenWidth),
      child: OutlinedButton(
        onPressed: () async {
          bool isLoggedIn = false;
          WidgetUtils.showLoaderDialog(context, "Signing In...");
          if (this.identifier == 0)
            isLoggedIn = await WebService.signInWithFacebook();
          else if (this.identifier == 1)
            isLoggedIn = await WebService.signInWithGoogle();
          if (isLoggedIn) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String? phoneNumber = preferences.getString(Constants.PHONE_NUMBER);
            Navigator.of(context).pop();
            if (phoneNumber == null || phoneNumber.isEmpty) {
              Navigator.pushReplacementNamed(
                  context, EnterPhoneNumberScreen.routeName);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, ParentScreen.routeName, (route) => false);
            }
          } else {
            Navigator.of(context).pop();
            WidgetUtils.showToast(
              "Sign-In failed! try again later",
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(identifier == 0
                ? "assets/images/facebook_f.png"
                : "assets/images/google_g.png"),
            Text(
              identifier == 0 ? "Facebook" : "Google",
              style: TextStyle(
                color: Colors.white,
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontSize: 16,
              ),
            ),
          ],
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: identifier == 0 ? HexColor("#3C5A99") : HexColor("#EC462D"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  double calculateSocialButtonWidth(double screenWidth) {
    return screenWidth - (screenWidth * 0.63);
  }
}
