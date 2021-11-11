import 'package:flutter/cupertino.dart';

class CurrentPage extends ChangeNotifier {

  List<Widget> _sliderData = [
    Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        "assets/images/Slider.png",
        scale: 1.5,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        "assets/images/Closing-Deal02.png",
        scale: 1.5,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        "assets/images/Closing-Deal-03.png",
        scale: 1.5,
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