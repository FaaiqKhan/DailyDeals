import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PriceDetailsAndAddToCartButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fontSize = 11.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Prize Details",
            style: TextStyle(
              fontFamily: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .fontFamily,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: fontSize
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              HexColor("#303030"),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Add to Cart",
            style: TextStyle(
              fontFamily: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .fontFamily,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: fontSize
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              HexColor("#DA2B0E"),
            ),
          ),
        ),
      ],
    );
  }

}