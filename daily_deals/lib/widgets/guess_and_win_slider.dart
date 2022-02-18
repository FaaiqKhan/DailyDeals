import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/views/guess_and_win_view.dart';

import 'package:flutter/material.dart';

class GuessAndWinSlider extends StatelessWidget {
  final List<ProductModal> _modal;

  GuessAndWinSlider(this._modal);

  List<Widget> prepareData() {
    List<Widget> data = [];
    for (int i = 0; i < _modal.length; i++) {
      data.add(GuessAndWin(_modal.elementAt(i)));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("GUESS & WIN", style: Theme.of(context).textTheme.subtitle2),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: prepareData(),
          ),
        ),
      ],
    );
  }
}
