class WinnerModal {
  String customerName, productName, amount, image;

  WinnerModal(this.customerName, this.productName, this.amount, this.image);

  factory WinnerModal.fromJson(Map<String, dynamic> json) =>
      _$WinnerModalFromJson(json);
}

WinnerModal _$WinnerModalFromJson(Map<String, dynamic> json) {
  return WinnerModal(
    json['customer_name'],
    json['product_name'],
    json['product_amount'],
    json['product_image'],
  );
}
