import 'package:daily_deals/views/app_bar_title.dart';
import 'package:daily_deals/views/coupon_view.dart';
import 'package:daily_deals/widgets/app_bar_back_button.dart';
import 'package:daily_deals/widgets/app_bar_profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("My Coupons"),
        actions: [AppBarProfileButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 25.0, right: 10.0),
          child: Column(
            children: [
              CouponView(
                "Guess & win",
                "assets/images/temp_3.png",
                "Mercedes benz MZ-66",
                "Hoddy of CK",
                "250.00",
                "20th Nov",
                "2021"
              )
            ],
          ),
        ),
      ),
    );
  }
}
