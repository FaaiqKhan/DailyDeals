import 'dart:async';

import 'package:daily_deals/screens/enter_phone_number_screen.dart';
import 'package:daily_deals/screens/language_screen.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/utils/constants.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/video/daily_deals_splash.mp4");

  @override
  Widget build(BuildContext context) {
    Utils.moveToNextScreenAfterCertainTime(6, () async {
      final preferences = await SharedPreferences.getInstance();
      String fcmToken = preferences.getString(Constants.FCM_TOKEN) ?? "";
      if (fcmToken.isEmpty) {
        String token = await FirebaseMessaging.instance.getToken() ?? "";
        preferences.setString(Constants.FCM_TOKEN, token);
      }
      String routeName = LanguageSelection.routeName;
      if (preferences.get(Constants.ACCESS_TOKEN) != null) {
        String? phoneNumber =
            preferences.getString(Constants.PHONE_NUMBER) ?? "";
        phoneNumber.isNotEmpty
            ? routeName = ParentScreen.routeName
            : routeName = EnterPhoneNumberScreen.routeName;
      }
      _videoPlayerController.dispose().then(
            (value) => Navigator.pushReplacementNamed(
          context,
          routeName,
        ),
      );
    });
    return Scaffold(
      backgroundColor: Colors.red,
      body: FutureBuilder(
        future: startVideo(),
        builder: (_, snapShot) {
          if (snapShot.hasData) {
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: _videoPlayerController.value.size.width,
                  height: _videoPlayerController.value.size.height,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<bool> startVideo() async {
    await _videoPlayerController.initialize();
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.setLooping(false);
      _videoPlayerController.setVolume(0.0);
      _videoPlayerController.play();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
