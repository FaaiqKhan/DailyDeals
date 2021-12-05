import 'package:daily_deals/modals/cart_item_modal.dart';
import 'package:hive/hive.dart';

class CartItemAdapter extends TypeAdapter<CartItemModal> {
  @override
  int get typeId => 0;

  @override
  CartItemModal read(BinaryReader reader) {
    return CartItemModal(
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModal obj) {
    writer.write(obj.productId);
    writer.write(obj.productImage);
    writer.write(obj.price);
    writer.write(obj.description);
    writer.write(obj.itemCount);
    writer.write(obj.prize);
    writer.write(obj.type);
    writer.write(obj.mySequence);
  }
}
