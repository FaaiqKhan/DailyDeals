import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DeliveryModes extends StatefulWidget {
  final String? deliveryPrice;
  final Function? updateDeliveryMode;

  DeliveryModes({this.deliveryPrice, this.updateDeliveryMode});

  @override
  State<StatefulWidget> createState() {
    return _DeliveryModesState();
  }
}

class _DeliveryModesState extends State<DeliveryModes> {
  final Color selectedColor = Colors.white;
  final Color unSelectedColor = HexColor("#383838");
  final List<int> deliveryModes = [0, 1, 2];
  int deliveryMode = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 10.0),
        // Charity
        Column(
          children: [
            // Image and description
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 4.0, top: 10.0, right: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Donate product and get additional coupons",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                      fontSize: 8,
                      color: HexColor("#3B302E"),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/images/cart/charity_icon.png",
                    scale: 2.7,
                  ),
                ],
              ),
            ),
            // Selection button
            Radio(
              value: deliveryModes[0],
              groupValue: deliveryMode,
              onChanged: (value) {
                setState(() {
                  deliveryMode = value as int;
                });
                widget.updateDeliveryMode!(value);
              },
              fillColor: MaterialStateColor.resolveWith(
                (states) => deliveryMode == 0
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              hoverColor: Colors.amber,
            ),
          ],
        ),
        // Delivery
        Column(
          children: [
            // Image and description
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 4.0, top: 10.0, right: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Standard delivery ${widget.deliveryPrice ?? "free"}",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                      fontSize: 8,
                      color: HexColor("#3B302E"),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/images/cart/delivery_icon.png",
                    scale: 2.7,
                  ),
                ],
              ),
            ),
            // Selection button
            Radio(
              value: deliveryModes[1],
              groupValue: deliveryMode,
              onChanged: (value) {
                setState(() {
                  deliveryMode = value as int;
                });
                widget.updateDeliveryMode!(value);
              },
              fillColor: MaterialStateColor.resolveWith(
                (states) => deliveryMode == 1
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              hoverColor: Colors.amber,
            ),
          ],
        ),
        // Pickup
        Column(
          children: [
            // Image and description
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 4.0, top: 10.0, right: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Self collection from our stores",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle2!.fontFamily,
                      fontSize: 8,
                      color: HexColor("#3B302E"),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/images/cart/pickup_icon.png",
                    scale: 2.7,
                  ),
                ],
              ),
            ),
            // Selection button
            Radio(
              value: deliveryModes[2],
              groupValue: deliveryMode,
              onChanged: (value) {
                setState(() {
                  deliveryMode = value as int;
                });
                widget.updateDeliveryMode!(value);
              },
              fillColor: MaterialStateColor.resolveWith(
                (states) => deliveryMode == 2
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              hoverColor: Colors.amber,
            ),
          ],
        ),
        SizedBox(width: 10.0),
      ],
    );
  }
}
