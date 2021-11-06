import 'dart:async';

import 'package:daily_deals/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/video/daily_deals_splash.mp4");

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 6),
        () => {
              _videoPlayerController.dispose().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, WelcomeScreen.routeName)),
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
