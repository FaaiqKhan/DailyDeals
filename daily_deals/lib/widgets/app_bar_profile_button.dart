import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBarProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: HexColor("#E73E22"), width: 2),
        borderRadius: BorderRadius.circular(50),
        color: HexColor("#E73E22"),
      ),
      child: Image.asset(
        "assets/images/person_icon.png",
        color: Colors.white,
      ),
    );
  }
}
