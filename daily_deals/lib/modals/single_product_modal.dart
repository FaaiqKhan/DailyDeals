class SingleProductModal {
  final String productName, productImage, productPrice;

  SingleProductModal(
    this.productName,
    this.productImage,
    this.productPrice,
  );

  factory SingleProductModal.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

SingleProductModal _$ProductFromJson(Map<String, dynamic> json) {
  return SingleProductModal(
    json['title'],
    json['image'],
    json['price'],
  );
}
