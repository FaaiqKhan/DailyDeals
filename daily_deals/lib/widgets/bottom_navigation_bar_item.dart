import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final IconData? _icon;
  final String _label;
  final String _imagePath;
  final double _dashWidth;
  final double _sizePercent;

  CustomBottomNavigationBar(
    this._icon,
    this._dashWidth,
    this._sizePercent,
    this._label, [
    this._imagePath = "",
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _dashWidth * _sizePercent,
      alignment: Alignment.center,
      child: Column(
        children: [
          Consumer<CartCostProvider>(
            builder: (_, cartProvider, iconWidget) {
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  iconWidget!,
                  Visibility(
                    visible: _label == 'Cart' && cartProvider.itemCount > 0,
                    child: CircleAvatar(
                      radius: 6.5,
                      backgroundColor: Colors.red,
                      child: Text(
                        "${cartProvider.itemCount}",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  )
                ],
              );
            },
            child: _icon != null
                ? Icon(_icon, size: _dashWidth * 0.055)
                : Image.asset(_imagePath, scale: 17.5, color: Colors.white),
          ),
          Text(_label, style: TextStyle(color: Colors.white, fontSize: 10)),
          Divider(thickness: 5.0)
        ],
      ),
    );
  }
}
