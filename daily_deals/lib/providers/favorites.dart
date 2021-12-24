import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _myFavoriteProducts = [];

  void initId(String id) {
    _myFavoriteProducts.add(id);
  }

  void addOrRemoveToFavorites(BuildContext context, String id) {
    bool addToFavorites = true;
    String message = "Adding to favorites";
    if (_myFavoriteProducts.contains(id)) {
      addToFavorites = false;
      message = "Removing from favorites";
    }
    WidgetUtils.showLoaderDialog(context, message);
    WebService.addToOrRemoveFromFavorites(id, addToFavorites).then((value) {
      if (value) {
        if (addToFavorites)
          _myFavoriteProducts.add(id);
        else
          _myFavoriteProducts.remove(id);
        notifyListeners();
      }
      Navigator.of(context).pop();
    });
  }

  bool contains(String? id) {
    return _myFavoriteProducts.contains(id);
  }
}