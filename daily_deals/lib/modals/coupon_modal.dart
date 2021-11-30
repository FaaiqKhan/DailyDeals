class CouponModal {
  String? couponId, image, title, date, sold, total, couponType;
  List<String>? shuffleNumbers;

  CouponModal({
    this.couponId,
    this.image,
    this.title,
    this.date,
    this.total,
    this.shuffleNumbers,
    this.sold,
    this.couponType,
  });

  factory CouponModal.fromJson(Map<String, dynamic> json) =>
      _$CouponModalFromJson(json);
}

CouponModal _$CouponModalFromJson(Map<String, dynamic> json) {
  List<String> numbers = [];
  numbers.addAll((json['sufflfe_number'] as List<String>));
  return CouponModal(
    couponId: json['coupon_id'],
    image: json['image'],
    title: json['title'],
    date: json['date'],
    total: json['total'],
    shuffleNumbers: numbers,
    sold: json['sold_out'],
    couponType: json['coupon_type'],
  );
}
