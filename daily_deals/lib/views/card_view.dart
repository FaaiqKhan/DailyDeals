import 'package:daily_deals/widgets/remaining_product_count.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CardView extends StatelessWidget {
  final List<Widget> data;
  final int totalItems, remainingItems;

  CardView(this.data, {this.totalItems = 1, this.remainingItems = 1});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              // Right side
              Container(
                decoration: BoxDecoration(
                  color: HexColor("#F83615"),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                  ),
                ),
                child: data.first,
              ),
              // Left side
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: data.last,
              ),
            ],
          ),
          RemainingProductCount(
            total: this.totalItems,
            remaining: this.remainingItems,
          ),
        ],
      ),
    );
  }
}
