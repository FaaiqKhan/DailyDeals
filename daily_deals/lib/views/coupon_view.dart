import 'package:daily_deals/modals/coupon_modal.dart';
import 'package:daily_deals/views/digit_view.dart';
import 'package:daily_deals/widgets/remaining_product_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

class CouponView extends StatelessWidget {
  final CouponModal modal;

  CouponView(this.modal);

  List<Widget> digitsView(List<String>? numbers) {
    List<Widget> view = [];
    if (numbers != null && numbers.isNotEmpty) {
      for (String number in numbers) {
        view.add(DigitView(number, "#ACACAD", "#E4E4E4"));
        view.add(SizedBox(width: 5.0));
      }
    }
    return view;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerHeight = screenWidth * 0.5;
    List<String> date = modal.date!.split(" ");

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      color: HexColor("#F7F7F7"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: screenWidth,
        height: containerHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  modal.couponType == null ? "" : modal.couponType!,
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.subtitle2!.fontFamily,
                    color: HexColor("#4E4C4C"),
                  ),
                ),
                Image.network(modal.image!, scale: 4.5)
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: RemainingProductCount(
                total: modal.total,
                remaining: modal.sold,
                width: screenWidth * 0.110,
                height: screenWidth * 0.35,
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 140),
                            child: Text(
                              "You appear in ${modal.prizeTitle}",
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontFamily,
                                color: HexColor("#ACACAD"),
                                fontSize: 9,
                              ),
                            ),
                          ),
                          Text(
                            "luck draw by purchasing",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                              color: HexColor("#ACACAD"),
                              fontSize: 9,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            modal.title!,
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              fontSize: 11,
                              color: HexColor("#4E4C4C"),
                            ),
                          ),
                          Text(
                            "AED ${modal.productPrice}",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              fontSize: 11,
                              color: HexColor("#4E4C4C"),
                            ),
                          ),
                        ],
                      ),
                      // Sequence
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "ID: ",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .fontFamily,
                                  color: HexColor("#ACACAD"),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // Coupon Identifier
                              Text(
                                modal.couponIdentifier,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#ACACAD"),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: modal.shuffleNumbers!.isNotEmpty,
                            child: Text(
                              "Your sequence",
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontFamily,
                                color: HexColor("#ACACAD"),
                                fontSize: 9,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          // Coupon Sequence
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: digitsView(modal.shuffleNumbers),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Image.asset("assets/images/lottery_icon.png", scale: 4.5),
                      Text(
                        "Lucky Draw",
                        style: TextStyle(
                          fontSize: 7,
                          color: HexColor("#ACACAD"),
                          fontFamily:
                          Theme.of(context).textTheme.bodyText1!.fontFamily,
                        ),
                      ),
                      Text(
                        date[2] + " " + date[1],
                        style: TextStyle(
                          fontSize: 7,
                          color: HexColor("#4E4C4C"),
                          fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                        ),
                      ),
                      Text(
                        date[0],
                        style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#4E4C4C"),
                          fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
