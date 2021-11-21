import 'package:flutter/cupertino.dart';

class CartCheckoutView extends StatelessWidget {
  final String title;

  CartCheckoutView(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
      ],
    );
  }

}