import 'package:daily_deals/views/coupon_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 25.0, right: 10.0),
        child: Column(
          children: [
            CouponView(
                "Guess & win",
                "assets/images/temp_3.png",
                "Mercedes benz",
                "Hoddy of CK",
                "250.00",
                "20th Nov",
                "2021"
            )
          ],
        ),
      ),
    );
  }
}
