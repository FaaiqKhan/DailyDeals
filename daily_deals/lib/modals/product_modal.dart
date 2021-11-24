class ProductModal {
  final int? soldOut, total;
  final String? dealId, image, title, subTitle, description;
  var timeStamp;

  ProductModal({
    this.dealId,
    this.timeStamp,
    this.image,
    this.title,
    this.subTitle,
    this.description,
    this.soldOut,
    this.total,
  });

  factory ProductModal.fromJson(Map<String, dynamic> json) =>
      _$ClosingSoonFromJson(json);
}

ProductModal _$ClosingSoonFromJson(Map<String, dynamic> json) {
  return ProductModal(
    dealId: json['deal_id'],
    timeStamp: json['time_stamp'],
    image: json['image'],
    title: json['title'],
    subTitle: json['sub_title'],
    description: json['description'],
    soldOut: json['sold_out'],
    total: json['total'],
  );
}
