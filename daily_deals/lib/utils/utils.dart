import 'dart:async';

import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/screens/code_verification_screen.dart';
import 'package:daily_deals/screens/create_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static double calculateButtonHeight(double screenWidth) {
    return 44;
  }

  static EdgeInsetsGeometry calculateScreenLeftRightPadding(
      double screenWidth) {
    return const EdgeInsets.only(left: 20.0, right: 20.0);
  }

  static EdgeInsetsGeometry calculateScreenLeftRightPaddingWithTop(
      double screenWidth) {
    return const EdgeInsets.only(left: 20.0, top: 20.0);
  }

  static double buttonBorderRadius() {
    return 10.0;
  }

  static double calculatePatternHeight(double screenWidth) {
    return screenWidth - (screenWidth * 0.55);
  }

  static double calculatePatternWidth(double screenWidth) {
    return screenWidth - (screenWidth * 0.50);
  }

  static showLoaderDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void requestOtp(BuildContext context, UserDetails userDetails,
      {Function? timer, bool forgotPassword = false}) async {
    Utils.showLoaderDialog(context, "Please wait...");
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: userDetails.getNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          print("verificationCompleted");
          // if (forgotPassword) {
          //   Timer(Duration(seconds: 2), () {
          //     Utils.showLoaderDialog(context, "Verifying code...");
          //     Timer(Duration(seconds: 2), () {
          //       Navigator.pushReplacementNamed(
          //         context,
          //         CreatePassword.routeName,
          //         arguments: userDetails.getUserId,
          //       );
          //     });
          //   });
          // }
        },
        verificationFailed: (FirebaseAuthException e) {
          Navigator.of(context).pop();
          // TODO show toast
          print("verificationFailed: $e");
        },
        codeSent: (String verificationId, int? resendToken) async {
          print("codeSent");
          Navigator.of(context).pop();
          if (timer == null) {
            Navigator.pushNamed(
              context,
              CodeVerificationScreen.routeName,
              arguments: {
                "userDetails": userDetails,
                "verificationId": verificationId,
                "forgotPassword": forgotPassword,
              },
            );
          } else {
            timer();
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout");
        },
      );
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  static double pageHeight(double screenHeight) {
    return screenHeight - (screenHeight * 0.9);
  }
}
