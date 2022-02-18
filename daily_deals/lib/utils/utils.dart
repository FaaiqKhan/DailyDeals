import 'dart:async';

import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/modals/home_data_modal.dart';
import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/modals/winner_modal.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/screens/code_verification_screen.dart';
import 'package:daily_deals/screens/sign_in_up_screen.dart';
import 'package:daily_deals/views/winner_card_view.dart';
import 'package:daily_deals/widgets/closing_soon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'widget_utils.dart';

class Utils {
  static double screenPadding = 20.0;
  static double elementPadding = 8.0;
  static HomeDataModal? homeDataModal;

  static double calculateButtonHeight(double screenWidth) {
    return 44;
  }

  static EdgeInsetsGeometry calculateScreenLeftRightPadding(
      double screenWidth) {
    return const EdgeInsets.only(left: 40.0, right: 40.0);
  }

  static EdgeInsetsGeometry calculateScreenLeftRightPaddingWithTop(
      double screenWidth) {
    return const EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0);
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

  static void requestOtp(
    BuildContext context,
    UserDetails userDetails, {
    Function? timer,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: userDetails.getNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          print("verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {
          Navigator.of(context).pop();
          WidgetUtils.showToast(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.of(context).pop();
          if (timer == null) {
            Navigator.pushNamed(
              context,
              CodeVerificationScreen.routeName,
              arguments: {
                "userDetails": userDetails,
                "verificationId": verificationId
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
      WidgetUtils.showToast("request otp: " + e.toString());
      Navigator.of(context).pop();
    }
  }

  static double pageHeight(double screenHeight) {
    return screenHeight - (screenHeight * 0.9);
  }

  static List<Widget> prepareListDataForView(
      List<Object> modal, bool isForWinner) {
    List<Widget> data = [];
    int dataLength = modal.length;
    int halfOfList = (dataLength / 2).ceil();
    int endIndex = dataLength - 1;
    for (int i = 0; i <= halfOfList; i = i + 2) {
      data.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isForWinner
                ? WinnerCard(modal.elementAt(i) as WinnerModal)
                : ClosingSoon(modal.elementAt(i) as ProductModal),
            if (i != endIndex)
              isForWinner
                  ? WinnerCard(modal[i + 1] as WinnerModal)
                  : ClosingSoon(modal.elementAt(i + 1) as ProductModal),
          ],
        ),
      );
    }
    if (dataLength > 1 && dataLength % 2 != 0) {
      data.add(
        Row(
          children: [
            isForWinner
                ? WinnerCard(modal.last as WinnerModal)
                : ClosingSoon(modal.last as ProductModal)
          ],
        ),
      );
    }
    return data;
  }

  static void moveToNextScreenAfterCertainTime(int duration, Function move) {
    Timer(Duration(seconds: duration), () {
      move();
    });
  }

  static bool isKeyboardVisible(BuildContext context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  static Future<void> shareProduct(
      String productLink, String productDetails) async {
    await Share.share(productLink, subject: productDetails);
  }

  static Future<void> storeUserDetails(var data, String? provider) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(Constants.ACCESS_TOKEN, data['access_token']);
    await preferences.setString(Constants.USER_ID, data['customer_id']);
    await preferences.setString(Constants.USER_NAME, data['customer_name']);
    await preferences.setString(Constants.PHONE_NUMBER, data['phonenumber']);
    await preferences.setString(Constants.EMAIL, data['email']);
    if (provider != null)
      await preferences.setString(Constants.SOCIAL_LOGIN_PROVIDER, provider);
  }

  static Future<void> logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
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
  }
}
