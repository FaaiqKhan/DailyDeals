class CartItemModal {
  String productId, productImage, price, prize, description, type;
  int itemCount;
  Map<dynamic, dynamic> mySequence;

  CartItemModal(
    this.productId,
    this.productImage,
    this.price,
    this.description,
    this.itemCount,
    this.prize,
    this.type,
    this.mySequence,
  );

  Map<dynamic, dynamic> toJson() => _$CartItemModalToJson(this);
}

Map<dynamic, dynamic> _$CartItemModalToJson(CartItemModal instance) =>
    <dynamic, dynamic>{
      'deal_id': instance.productId,
      'product_image': instance.productImage,
      'price': instance.price,
      'description': instance.description,
      'item_count': instance.itemCount,
      'prize': instance.prize,
      'deal_type': instance.type,
      'sequence': instance.mySequence,
    };
