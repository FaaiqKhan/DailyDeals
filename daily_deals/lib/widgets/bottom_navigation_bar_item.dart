import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final IconData? _icon;
  final String _label;
  final int? _cartItemsCount;
  final String _imagePath;
  final double _dashWidth;
  final double _sizePercent;

  CustomBottomNavigationBar(
    this._icon,
    this._dashWidth,
    this._sizePercent,
    this._label, [
    this._cartItemsCount,
    this._imagePath = "",
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _dashWidth * _sizePercent,
      alignment: Alignment.center,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              if (_icon != null) Icon(_icon, size: _dashWidth * 0.055,) else Image.asset(_imagePath),
              Visibility(
                visible: _cartItemsCount != null,
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                  child: Text("$_cartItemsCount"),
                ),
              )
            ],
          ),
          Text(_label, style: TextStyle(color: Colors.white, fontSize: 10)),
          Divider(thickness: 5.0)
        ],
      ),
    );
  }
}
