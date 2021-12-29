import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:daily_deals/modals/detailed_product_modal.dart';
import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Utilities {
  Future<void> populateData(
    BuildContext context,
    DetailedProductModal productModal,
    int productCount,
    Map<dynamic, dynamic> mySequence,
    double productPrice,
  ) async {
    CartItemModal cartModal = CartItemModal(
      productModal.dealId!,
      productModal.productImage!,
      productModal.price!,
      productModal.description!,
      productCount,
      productModal.price!,
      productModal.type!,
      mySequence,
    );
    var cartItemBox = await Hive.openBox<CartItemModal>('cartItem');
    await cartItemBox.put(productModal.dealId, cartModal);
    await cartItemBox.close();
    Provider.of<CartCostProvider>(context, listen: false).updateCartValue(
      productPrice * productCount,
      productCount,
    );
  }
}
