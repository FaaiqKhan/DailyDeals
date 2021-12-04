import 'package:flutter/cupertino.dart';

class CartCostProvider extends ChangeNotifier {
  double cartCost = 0.0;
  int itemCount = 0;
  int? couponCount;

  void initValue(double cost, int itemCount) {
    this.cartCost = cost;
    this.itemCount = itemCount;
  }

  void updateCartValue(double cartCost, int itemCount, [int couponCount = 0]) {
    this.cartCost = cartCost;
    this.couponCount = couponCount;
    this.itemCount = itemCount;
    notifyListeners();
  }
}