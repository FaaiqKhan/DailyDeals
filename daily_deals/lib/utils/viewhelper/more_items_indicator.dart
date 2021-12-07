import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreItemsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.grey.shade400,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 20.0),
          Text("Swipe For More", style: TextStyle(color: Colors.white)),
          SizedBox(width: 20.0),
          Icon(Icons.arrow_forward),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }

}