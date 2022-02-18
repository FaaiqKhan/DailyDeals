import 'package:flutter/material.dart';

class CartItemsProvider with ChangeNotifier {
  Map<String, Widget> _items = {};

  void initItems(Map<String, Widget> items) {
    this._items = items;
  }

  Map<String, Widget> get items {
    return _items;
  }

  int get count {
    return _items.length;
  }

  void deleteItem(String id) {
    _items.remove(id);
    _items.remove(id + "d");
    notifyListeners();
  }

}