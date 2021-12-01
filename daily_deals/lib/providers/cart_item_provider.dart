import 'package:flutter/cupertino.dart';

class CartItemsProvider with ChangeNotifier {
  Map<String, Widget> _items = {};

  void initItems(Map<String, Widget> items) {
    this._items = items;
  }

  Map<String, Widget> get items {
    return _items;
  }

  void deleteItem(String id) {
    _items.remove(id);
    _items.remove(id + "d");
    notifyListeners();
  }

}