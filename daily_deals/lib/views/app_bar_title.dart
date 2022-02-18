
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  AppBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
        fontSize: 20,
      ),
    );
  }

}