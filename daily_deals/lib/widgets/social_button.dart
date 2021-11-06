import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final BuildContext? context;
  final Function? functionality;
  final Color? color;

  SocialButton({
    @required this.context,
    @required this.iconPath,
    @required this.text,
    @required this.functionality,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: calculateSocialButtonWidth(screenWidth),
      height: Utils.calculateButtonHeight(screenWidth),
      child: OutlinedButton(
        onPressed: () => functionality,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(iconPath!),
            Text(
              text!,
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
          backgroundColor: color,
          side: BorderSide(
            color: color!,
          ),
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
