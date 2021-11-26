import 'dart:convert';
import 'dart:io';

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
}
