import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/cart_card_view.dart';
import 'package:daily_deals/widgets/delivery_modes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutItemView extends StatelessWidget {
  final CartItemModal item;
  final Function addressRequired;

  CheckoutItemView(this.item, this.addressRequired);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(children: generateItemsView(context, item)),
    );
  }

  List<Widget> generateItemsView(BuildContext context, CartItemModal modal) {
    List<Widget> items = [];
    for (int i = 1; i <= modal.itemCount; i++) {
      items.add(CartCardView(modal, isFromCheckout: true));
      items.add(DeliveryModes(
        deliveryPrice: "35.0",
        updateDeliveryMode: updateDeliveryStatus,
      ));
      items.add(Visibility(
        visible: modal.type == "2",
        child: Column(
          children: [
            Text(
              "Your sequence of this section",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    WidgetUtils.generateSequenceView(context, modal.mySequence[i] ?? []),
              ),
            )
          ],
        ),
      ));
      if (i >= 1 && i != modal.itemCount)
        items.add(Divider(thickness: 2, color: Colors.grey));
    }
    return items;
  }

  void updateDeliveryStatus(int statusCode, int couponCount) {
    addressRequired(item.productId, statusCode, couponCount);
  }
}
