class DetailedProductModal {
  final String? dealId, productImage, title, subTitle, description;
  final String? priceDescription, price, type;
  final int? soldOut, total;
  final List<String> bannerImages;
  int timeStamp;

  DetailedProductModal({
    this.dealId,
    this.productImage,
    this.bannerImages = const [],
    this.title,
    this.subTitle,
    this.priceDescription,
    this.price,
    this.description,
    this.total,
    this.soldOut,
    this.timeStamp = 0,
    this.type = "0",
  });

  factory DetailedProductModal.toJson(Map<String, dynamic> json) => _$DetailedProductModal(json);
}

DetailedProductModal _$DetailedProductModal(Map<String, dynamic> json) {
  return DetailedProductModal(
    dealId: json['deal_id'],
    productImage: json['image'],
    bannerImages: (json['banner_image'] as List).map((e) => e as String).toList(),
    title: json['title'],
    subTitle: json['sub_title'],
    priceDescription: json['price_description'],
    price: json['price'],
    description: json['description'],
    total: json['total'],
    soldOut: json['sold_out'],
    timeStamp: json['time_stamp'],
    type: json['deal_type'],
  );
}
