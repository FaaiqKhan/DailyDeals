import 'dart:convert';

import 'package:daily_deals/service/network_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'user_details.dart';

class Auth extends ChangeNotifier {
  String? token;
  UserDetails? user;

  Future<bool> signUp(UserDetails userDetails) async {
    NetworkHandler networkHandler = NetworkHandler(endPoint: "/user/index");
    var response = await http.post(
      Uri.parse(networkHandler.getUrl),
      body: userDetails.toJson(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Future.value(true);
    } else {
      print(response.body);
      return Future.value(false);
    }
  }

  Future<bool> signIn(UserDetails userDetails) async {
    NetworkHandler networkHandler = NetworkHandler(endPoint: "/auth/login");
    var response = await http.post(
      Uri.parse(networkHandler.getUrl),
      body: {
        'email': userDetails.getEmail,
        'password': userDetails.getPassword,
        'deviceToken': '28o3kasdjkldaskl',
        'language': 'en',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      var data = json.decode(response.body);
      if (data['success'] == false) {
        Fluttertoast.showToast(
          msg: data['error'],
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("access_token", data['access_token']);
        await preferences.setString("user_id", data['customer_id']);
      }
      return Future.value(data['success']);
    } else {
      print(response.body);
      return Future.value(false);
    }
  }

  Future<Map> verifyNumber(String number) async {
    NetworkHandler networkHandler = NetworkHandler(endPoint: "/auth/resetPwd");
    var response = await http.post(Uri.parse(networkHandler.getUrl), headers: {
      "key": "Authorization",
      "type": "text",
      "value":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJ1c2VybmFtZSI6ImF3dXNtYW5pMzBAZ21haWwuY29tIiwiaWF0IjoxNjA5Mzk1Nzg2LCJleHAiOjUyMDkzOTU3ODYsInJvbGUiOiIxIn0.1alhBbBlnxh33WwtO-E0bnM2tlj74MVXK4QNaRiil7c"
    }, body: {
      'phone': number
    });
    if (response.statusCode == 200) {
      print(response.body);
      var data = json.decode(response.body);
      return Future.value({
        'verified': true,
        'userId': data['user_id'],
      });
    } else {
      print(response.body);
      return Future.value({
        'verified': false,
      });
    }
  }

  Future<bool> updatePassword(String userId, String password) async {
    NetworkHandler networkHandler = NetworkHandler(endPoint: "/auth/updatePwd");
    var response = await http.post(Uri.parse(networkHandler.getUrl), headers: {
      "key": "Authorization",
      "type": "text",
      "value":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJ1c2VybmFtZSI6ImF3dXNtYW5pMzBAZ21haWwuY29tIiwiaWF0IjoxNjA5Mzk1Nzg2LCJleHAiOjUyMDkzOTU3ODYsInJvbGUiOiIxIn0.1alhBbBlnxh33WwtO-E0bnM2tlj74MVXK4QNaRiil7c"
    }, body: {
      'user_id': userId,
      'user_pwd': password,
    });
    if (response.statusCode == 200) {
      print(response.body);
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      print(response.body);
      return Future.value(false);
    }
  }
}
