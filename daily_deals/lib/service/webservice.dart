import 'dart:convert';
import 'dart:io';

import 'package:daily_deals/modals/checkout_modal.dart';
import 'package:daily_deals/modals/coupon_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/modals/home_data_modal.dart';
import 'package:daily_deals/modals/single_product_modal.dart';
import 'package:daily_deals/service/network_handler.dart';
import 'package:daily_deals/utils/constants.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/views/single_product_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  static Future<HomeDataModal?> fetchData() async {
    if (Utils.homeDataModal == null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userId = preferences.getString(Constants.USER_ID);
      String? accessToken = preferences.getString(Constants.ACCESS_TOKEN);
      String endPoint = '/home/getHomeData?user_id=$userId';
      NetworkHandler handler = NetworkHandler(endPoint: endPoint);
      var response = await http.get(
        Uri.parse(handler.getUrl),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['success']) {
          return HomeDataModal.fromJson(json['data']);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return Utils.homeDataModal;
    }
  }

  static Future<DetailedProductModal?> fetchProductDetails(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    String? accessToken = preferences.getString("access_token");
    String endPoint = '/home/productdetails?user_id=$userId&deal_id=$id';
    NetworkHandler handler = NetworkHandler(endPoint: endPoint);
    var response = await http.get(
      Uri.parse(handler.getUrl),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        return DetailedProductModal.toJson(json['data']);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<CouponModal>?> fetchCoupons() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    String? accessToken = preferences.getString("access_token");
    String endPoint = '/home/mycoupons?user_id=$userId';
    NetworkHandler handler = NetworkHandler(endPoint: endPoint);
    var response = await http.get(Uri.parse(handler.getUrl), headers: {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        return (json['data'] as List)
            .map((e) => CouponModal.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      return null;
    }
  }

  static Future<List> checkoutProduct(CheckoutModal items) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString("access_token");
    String endPoint = '/home/checkout';
    NetworkHandler handler = NetworkHandler(endPoint: endPoint);
    var response = await http.post(Uri.parse(handler.getUrl),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(items));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        return Future.value([true, json['data']]);
      } else {
        return Future.value([false, json['errorMessage']]);
      }
    } else {
      return Future.value([false, 'Can\'t place order please try again later']);
    }
  }

  static Future<bool> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _socialLogin(googleUser, credential);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<bool> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      // Once signed in, return the UserCredential
      UserCredential credential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return Future.value(false);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<bool> _socialLogin(
    GoogleSignInAccount? googleUser,
    OAuthCredential credential,
  ) async {
    NetworkHandler handler = NetworkHandler(endPoint: '/auth/sociallogin');
    var response = await http.post(
      Uri.parse(handler.getUrl),
      body: {
        'firstname': googleUser!.displayName,
        'laststname': "",
        'email': googleUser.email,
        'image': googleUser.photoUrl,
        'deviceToken': credential.accessToken,
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        await Utils.storeUserDetails(json);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  static Future<List<SingleProductView>> fetchProducts() async {
    if (Utils.singleProducts != null && Utils.singleProducts!.isNotEmpty) {
      return Future.value(Utils.singleProducts);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(Constants.USER_ID);
    String endPointWithParam = "/home/getproductslist?user_id=$userId";
    String? accessToken = preferences.getString(Constants.ACCESS_TOKEN);
    NetworkHandler handler = NetworkHandler(endPoint: endPointWithParam);
    var response = await http.get(
      Uri.parse(handler.getUrl),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        List<SingleProductModal> products = (json['data']['products'] as List)
            .map((product) => SingleProductModal.fromJson(product))
            .toList();
        List<SingleProductView> productViews = [];
        for (SingleProductModal productModal in products) {
          productViews.add(
            SingleProductView(
              productModal.productName,
              productModal.productImage,
              productModal.productPrice,
            ),
          );
        }
        Utils.singleProducts = productViews;
        return productViews;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
