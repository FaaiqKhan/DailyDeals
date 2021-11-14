import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PriceDetailsAndAddToCartButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double elementSpacing = screenWidth * 0.03;

    return Row(
      children: [
        SizedBox(width: elementSpacing + 10),
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
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              HexColor("#303030"),
            ),
          ),
        ),
        SizedBox(width: elementSpacing),
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
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              HexColor("#DA2B0E"),
            ),
          ),
        ),
        SizedBox(width: elementSpacing + 10),
      ],
    );
  }

}