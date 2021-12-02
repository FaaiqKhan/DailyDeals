import 'package:flutter/cupertino.dart';

class CartCostProvider extends ChangeNotifier {
  double cartCost = 0.0;
  int couponCount = 0;
  int itemCount = 0;

  void initValue(double cost) {
    cartCost = cost;
  }

  void updateCartValue(double cartCost, int couponCount, int itemCount) {
    this.cartCost = cartCost;
    this.couponCount = couponCount;
    this.itemCount = itemCount;
    notifyListeners();
  }
}