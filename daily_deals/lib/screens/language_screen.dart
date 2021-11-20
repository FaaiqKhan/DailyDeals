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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ColorfulSafeArea(
        child: Padding(
          padding: Utils.calculateScreenLeftRightPadding(screenWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Your \n Language",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: screenWidth * 0.1,
              ),
              AppButton(
                context: context,
                text: "Arabic",
                functionality: () {
                  Navigator.pushReplacementNamed(
                    context,
                    WelcomeScreen.routeName,
                  );
                },
                lightBlackColor: true,
              ),
              SizedBox(
                height: 20,
              ),
              AppButton(
                context: context,
                text: "English",
                functionality: () {
                  Navigator.pushReplacementNamed(
                    context,
                    WelcomeScreen.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
