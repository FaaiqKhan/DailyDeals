
import 'package:flutter/material.dart';

class MoreItemsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.grey.shade400,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Swipe For More",
            style: TextStyle(
              color: Colors.white,
              fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
            ),
          ),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
