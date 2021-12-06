import 'dart:convert';
import 'dart:io';

import 'package:daily_deals/modals/checkout_modal.dart';
import 'package:daily_deals/modals/coupon_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/modals/home_data_modal.dart';
import 'package:daily_deals/service/network_handler.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  static Future<HomeDataModal?> fetchData() async {
    if (Utils.homeDataModal == null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userId = preferences.getString('user_id');
      String? accessToken = preferences.getString("access_token");
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
    var response = await http.get(
      Uri.parse(handler.getUrl),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      }
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        (json['data'] as List).map((e) => CouponModal.fromJson(json['data'])).toList();
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
      body: jsonEncode(items)
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
}
