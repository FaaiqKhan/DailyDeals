class DetailedProductModal {
  final String? dealId, productImage, title, subTitle, description;
  final String? priceDescription, price, type, prizeImage, prizeName;
  final int? soldOut, total;
  int timeStamp;

  DetailedProductModal({
    this.dealId,
    this.productImage,
    this.title,
    this.subTitle,
    this.priceDescription,
    this.price,
    this.description,
    this.total,
    this.soldOut,
    this.timeStamp = 0,
    this.type = "0",
    this.prizeImage,
    this.prizeName,
  });

  factory DetailedProductModal.toJson(Map<String, dynamic> json) => _$DetailedProductModal(json);
}

DetailedProductModal _$DetailedProductModal(Map<String, dynamic> json) {
  return DetailedProductModal(
    dealId: json['deal_id'],
    productImage: json['image'],
    title: json['title'],
    subTitle: json['sub_title'],
    priceDescription: json['price_description'],
    price: json['price'],
    description: json['description'],
    total: json['total'],
    soldOut: json['sold_out'],
    timeStamp: json['time_stamp'],
    type: json['deal_type'],
    prizeImage: json['prize_image'],
    prizeName: json['price_name'],
  );
}
