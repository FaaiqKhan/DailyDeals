import 'package:daily_deals/modals/coupon_modal.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/coupon_view.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  Widget prepareView(List<CouponModal> modal) {
    List<Widget> data = [];
    for (CouponModal cm in modal) data.add(CouponView(cm));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 25.0, right: 10.0),
        child: Column(children: data),
      ),
    );
  }

  Widget emptyCartView(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "OOPS!",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Image.asset("assets/images/empty_coupons_icon.png", scale: 3),
          Column(
            children: [
              Text("Oh! No coupons.", style: TextStyle(color: Colors.black)),
              Text(
                "Enter a draw now!",
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Image.asset("assets/images/sad_icon.png", scale: 10),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WebService.fetchCoupons(),
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          List<CouponModal> modal = snapShot.data as List<CouponModal>;
          return modal.isEmpty ? emptyCartView(context) : prepareView(modal);
        } else {
          return WidgetUtils.progressIndicator(context);
        }
      },
    );
  }
}
