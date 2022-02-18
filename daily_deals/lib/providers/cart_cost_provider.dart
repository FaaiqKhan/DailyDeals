import 'package:flutter/material.dart';

class CartCostProvider extends ChangeNotifier {
  double cartCost = 0.0;
  int itemCount = 0;
  int couponCount = 0;

  void initValue(double cost, int itemCount) {
    this.cartCost = cost;
    this.itemCount = itemCount;
  }

  void updateCouponCount(int count) {
    this.couponCount = count;
    notifyListeners();
  }

  void updateCartValue(double cartCost, int itemCount) {
    this.cartCost = cartCost;
    this.itemCount = itemCount;
    notifyListeners();
  }
}