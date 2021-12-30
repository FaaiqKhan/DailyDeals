import 'package:daily_deals/modals/notification_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationView extends StatelessWidget {
  final NotificationModal modal;
  final String formattedDate;

  NotificationView(this.modal, this.formattedDate);

  @override
  Widget build(BuildContext context) {
    final Color textColor = HexColor('#515C6F');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 37,
            backgroundColor: HexColor("#F5F5F5"),
            child: Image.network(modal.image, height: 40, width: 40),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      modal.title,
                      style: TextStyle(
                        color: textColor,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2!.fontFamily,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: textColor.withOpacity(0.5019607843137255),
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2!.fontFamily,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        modal.message,
                        style: TextStyle(
                          color: textColor,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1!.fontFamily,
                          fontSize: 15,
                        ),
                      ),
                      Divider(
                        thickness: 0.7,
                        color: textColor.withOpacity(0.5019607843137255),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
