class SingleProductModal {
  final String? productId;
  final String productName, productImage, productPrice;

  SingleProductModal(
    this.productName,
    this.productImage,
    this.productPrice, {
    this.productId,
  });

  factory SingleProductModal.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

SingleProductModal _$ProductFromJson(Map<String, dynamic> json) {
  bool hasProductId = json.containsKey('product_id');
  return SingleProductModal(
    json['title'],
    json['image'],
    json['price'],
    productId: hasProductId ? json['product_id'] : null,
  );
}
