class CouponModal {
  String? couponId, image, title, date, couponType;
  List<String>? shuffleNumbers;
  int sold, total;
  String couponIdentifier;

  CouponModal({
    this.couponId,
    this.image,
    this.title,
    this.date,
    this.total = 0,
    this.shuffleNumbers,
    this.sold = 0,
    this.couponType,
    this.couponIdentifier = "DD-000000",
  });

  factory CouponModal.fromJson(Map<String, dynamic> json) =>
      _$CouponModalFromJson(json);
}

CouponModal _$CouponModalFromJson(Map<String, dynamic> json) {
  List<dynamic> dynamicNumbers = json['sufflfe_number'];
  List<String> numbers = [];
  for (dynamic num in dynamicNumbers) {
    numbers.add(num as String);
  }
  return CouponModal(
    couponId: json['coupon_id'],
    image: json['image'],
    title: json['title'],
    date: json['date'],
    total: json['total'],
    shuffleNumbers: numbers,
    sold: json['sold_out'],
    couponType: json['coupon_type'],
    couponIdentifier: json['coupon_number'] ?? "DD-000000",
  );
}
