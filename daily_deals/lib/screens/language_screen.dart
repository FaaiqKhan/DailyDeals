import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/screens/welcome_screen.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelection extends StatelessWidget {
  static const String routeName = "/language-selection";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ColorfulSafeArea(
        child: Padding(
          padding: Utils.calculateScreenLeftRightPadding(screenWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Utils.pageHeight(screenHeight),
                  ),
                  Text(
                    "Select Your \n Language",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: screenWidth * 0.3,
                  ),
                  AppButton(
                    context: context,
                    text: "Arabic",
                    functionality: () {},
                    lightBlackColor: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    context: context,
                    text: "English",
                    functionality: () {},
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenWidth * 0.1),
                child: AppButton(
                  context: context,
                  text: "Continue",
                  functionality: () => Navigator.pushReplacementNamed(
                    context,
                    WelcomeScreen.routeName,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
