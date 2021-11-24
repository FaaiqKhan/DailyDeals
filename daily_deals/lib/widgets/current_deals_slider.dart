import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/views/current_deals_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentDealsSlider extends StatelessWidget {
  final List<ProductModal> _modal;
  final Axis scrollDirection;

  CurrentDealsSlider(this._modal, {this.scrollDirection = Axis.horizontal});

  List<Widget> prepareData() {
    List<Widget> data = [];
    for (int i = 0; i < _modal.length; i++) {
      data.add(CurrentDeals(_modal.elementAt(i)));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        scrollDirection == Axis.horizontal
            ? Text("Current Deals",
                style: Theme.of(context).textTheme.subtitle2)
            : SizedBox.shrink(),
        SingleChildScrollView(
          scrollDirection: scrollDirection,
          child: scrollDirection == Axis.horizontal
              ? Row(children: prepareData())
              : Column(children: prepareData()),
        ),
      ],
    );
  }
}
