import 'package:daily_deals/modals/coupon_modal.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/coupon_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  List<Widget> prepareData(List<CouponModal> modal) {
    if (modal.isEmpty) {
      return [
        Container(
          alignment: Alignment.center,
          height: 500,
          child: Text(
            "You don't have any coupons",
          ),
        )
      ];
    }
    List<Widget> data = [];
    for (CouponModal cm in modal) {
      data.add(CouponView(cm));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WebService.fetchCoupons(),
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 25.0, right: 10.0),
              child: Column(
                children: prepareData(snapShot.data as List<CouponModal>),
              ),
            ),
          );
        } else {
          return WidgetUtils.progressIndicator(context);
        }
      },
    );
  }
}
