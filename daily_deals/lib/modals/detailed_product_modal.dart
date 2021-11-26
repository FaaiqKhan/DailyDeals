class DetailedProductModal {
  final String? dealId, productImage, bannerImage, title, subTitle, description;
  final String? priceDescription, price;
  final int? soldOut, total;
  int timeStamp;

  DetailedProductModal({
    this.dealId,
    this.productImage,
    this.bannerImage,
    this.title,
    this.subTitle,
    this.priceDescription,
    this.price,
    this.description,
    this.total,
    this.soldOut,
    this.timeStamp = 0,
  });

  factory DetailedProductModal.toJson(Map<String, dynamic> json) => _$DetailedProductModal(json);
}

DetailedProductModal _$DetailedProductModal(Map<String, dynamic> json) {
  return DetailedProductModal(
    dealId: json['deal_id'],
    productImage: json['image'],
    bannerImage: json['banner_image'],
    title: json['title'],
    subTitle: json['sub_title'],
    priceDescription: json['price_description'],
    price: json['price'],
    description: json['description'],
    total: json['total'],
    soldOut: json['sold_out'],
    timeStamp: json['time_stamp'],
  );
}
