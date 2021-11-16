import 'package:flutter/cupertino.dart';

class CurrentPage extends ChangeNotifier {
  List<Widget> _sliderData = [
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        "assets/images/slider_1.png",
        fit: BoxFit.fill,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        "assets/images/slider_2.png",
        fit: BoxFit.fill,
      ),
    ),
  ];

  List<Widget> get allPages => _sliderData;

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int val) {
    _currentPage = val;
    notifyListeners();
  }
}
