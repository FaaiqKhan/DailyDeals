import 'dart:convert';
import 'dart:io';

import 'package:daily_deals/modals/checkout_modal.dart';
import 'package:daily_deals/modals/coupon_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/modals/home_data_modal.dart';
import 'package:daily_deals/modals/notification_modal.dart';
import 'package:daily_deals/modals/single_product_modal.dart';
import 'package:daily_deals/modals/social_login_modal.dart';
import 'package:daily_deals/service/network_handler.dart';
import 'package:daily_deals/utils/constants.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/notification_view.dart';
import 'package:daily_deals/views/single_product_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
    var response = await http.post(
      Uri.parse(handler.getUrl),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(items),
    );
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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      List<String> name = userCredential.user!.displayName!.split(" ");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? rId = preferences.getString(Constants.FCM_TOKEN);
      return await _socialLogin(
          new SocialLoginModal(name.first, name.last,
              userCredential.user!.email!, userCredential.user!.photoURL, rId),
          "google");
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
      List<String> name = credential.user!.displayName!.split(" ");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? rId = preferences.getString(Constants.FCM_TOKEN);
      return await _socialLogin(
          new SocialLoginModal(name.first, name.last, credential.user!.email!,
              credential.user!.photoURL, rId),
          "facebook");
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<bool> _socialLogin(
      SocialLoginModal modal, String provider) async {
    NetworkHandler handler = NetworkHandler(endPoint: '/auth/sociallogin');
    var response = await http.post(
      Uri.parse(handler.getUrl),
      body: modal.toJson(),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        await Utils.storeUserDetails(json, provider);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  static Future<List<SingleProductView>> fetchProducts() async {
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
        return productViews;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<bool> updatePhoneNumber(String phoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(Constants.USER_ID);
    String? accessToken = preferences.getString(Constants.ACCESS_TOKEN);
    NetworkHandler handler =
        NetworkHandler(endPoint: "/profile/editUserProfile");
    var response = await http.post(
      Uri.parse(handler.getUrl),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      },
      body: {
        'userid': userId,
        'phonenumber': phoneNumber,
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        await preferences.setString(Constants.PHONE_NUMBER, phoneNumber);
        return Future.value(true);
      } else {
        WidgetUtils.showToast(json['error']);
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  static Future<List<SingleProductView>> fetchFavoritesProducts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(Constants.USER_ID);
    String? accessToken = preferences.getString(Constants.ACCESS_TOKEN);
    String endPointWithParam = "/home/allfavourite?userid=$userId&language=en";
    NetworkHandler handler = NetworkHandler(endPoint: endPointWithParam);
    var response = await http.get(Uri.parse(handler.getUrl), headers: {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });
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
              productId: productModal.productId,
            ),
          );
        }
        return productViews;
      } else {
        return Future.value([]);
      }
    } else {
      return Future.value([]);
    }
  }

  static Future<bool> addToOrRemoveFromFavorites(String id, bool addTo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(Constants.USER_ID);
    String? accessToken = preferences.getString(Constants.ACCESS_TOKEN);
    String endPointWithParam =
        addTo ? "/home/addfavourite" : "/home/removefavourite";
    NetworkHandler handler = NetworkHandler(endPoint: endPointWithParam);
    var response = await http.post(
      Uri.parse(handler.getUrl),
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
      body: {'userid': userId, 'product_id': id},
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        WidgetUtils.showToast(json['data']);
        return Future.value(true);
      } else {
        WidgetUtils.showToast(json['errorDetails']);
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  static Future<List<NotificationView>?> fetchNotifications() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(Constants.USER_ID);
    String? accessToken = preferences.getString(Constants.ACCESS_TOKEN);
    if (userId != null) {
      String endPoint = "/home/notifications?userid=$userId";
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
          print(json['data']['notifucations']);
          List<NotificationView> notificationView = [];
          List<NotificationModal> notifications =
              (json['data']['notifucations'] as List)
                  .map((e) => NotificationModal.fromJson(e))
                  .toList();
          for (NotificationModal modal in notifications) {
            notificationView.add(
              NotificationView(modal, formatDateTime(modal.createdOn)),
            );
          }
          return Future.value(notificationView);
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      return null;
    }
  }

  static String formatDateTime(String createDateTime) {
    DateTime current = DateTime.now();
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(createDateTime);
    if (dateTime.year == current.year &&
        dateTime.month == current.month &&
        dateTime.day == current.day) {
      DateFormat timeFormat = DateFormat("HH:mm a");
      return timeFormat.format(dateTime);
    } else {
      DateFormat dateTimeFormat = new DateFormat("dd MMM");
      return dateTimeFormat.format(dateTime);
    }
  }
}
