class CheckoutModal {
  String userId, email, phone;
  String? firstName, zip, language, lastName, address, city, state;
  String total;
  List<CheckoutItemModal> items;

  CheckoutModal(
    this.userId,
    this.email,
    this.phone,
    this.total,
    this.items,);

  Map<String, dynamic> toJson() => _$CheckoutModalToJson(this);
}

Map<String, dynamic> _$CheckoutModalToJson(CheckoutModal instance) => <String, dynamic> {
  "userid": instance.userId,
  "email": instance.email,
  "phone": instance.phone,
  "firstname": "faiq",
  "lastname": "khan",
  "total": instance.total,
  "language": "en",
  "items": instance.items.map((item) => item.toJson()).toList(),
};

class CheckoutItemModal {
  String id, quantity;
  String subTotal;

  CheckoutItemModal(this.id, this.quantity, this.subTotal);

  Map<dynamic, dynamic> toJson() => _$itemToJson(this);
}

Map<dynamic, dynamic> _$itemToJson(CheckoutItemModal instance) =>
    <dynamic, dynamic>{
      "id": instance.id,
      "qty": instance.quantity,
      "subtotal": instance.subTotal,
    };
