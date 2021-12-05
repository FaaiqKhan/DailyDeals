import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/widgets/delivery_modes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckoutItemView extends StatelessWidget {
  final CartItemModal item;
  final Function addressRequired;

  CheckoutItemView(this.item, this.addressRequired);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Items
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(children: generateItemsView(item)),
        ),
        DeliveryModes(
          deliveryPrice: "35.0",
          updateDeliveryMode: updateDeliveryStatus,
        ),
      ],
    );
  }

  List<Widget> generateSequenceView(List<String> sequence) {
    List<Widget> sequenceViews = [];
    for (String number in sequence) {
      sequenceViews.add(
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: HexColor("#F83615"),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return sequenceViews;
  }

  List<Widget> generateItemsView(CartItemModal modal) {
    List<Widget> items = [];
    for (int i = 1; i <= modal.itemCount; i++) {
      items.add(CartCardView(modal, isFromCheckout: true));
      items.add(
        Visibility(
          visible: modal.type == "2",
          child: Column(
            children: [
              Text(
                "Your sequence of this section",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  top: 15.0,
                  right: 50.0,
                  bottom: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: generateSequenceView(modal.mySequence[i] ?? []),
                ),
              )
            ],
          ),
        ),
      );
      if (i >= 1) items.add(Divider(thickness: 2, color: Colors.grey));
    }
    return items;
  }

  void updateDeliveryStatus(int statusCode) {
    addressRequired(item.productId, statusCode);
  }
}
