import 'package:flutter/cupertino.dart';

class CartCostProvider extends ChangeNotifier {
  double cartCost = 0.0;
  int itemCount = 0;
  int couponCount = 0;

  void initValue(double cost, int itemCount, int couponCount) {
    this.cartCost = cost;
    this.itemCount = itemCount;
    this.couponCount = couponCount;
  }

  void updateCartValue(double cartCost, int itemCount, int couponCount) {
    this.cartCost = cartCost;
    this.couponCount = couponCount;
    this.itemCount = itemCount;
    notifyListeners();
  }
}