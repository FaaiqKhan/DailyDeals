import 'package:flutter/cupertino.dart';

class AddSubtractCartItemProvider extends ChangeNotifier {
  int items = 1;

  void addItem() {
    items++;
    notifyListeners();
  }

  void removeItem() {
    items--;
    notifyListeners();
  }
}