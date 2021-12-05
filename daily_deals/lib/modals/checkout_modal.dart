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
    this.items, {
    this.firstName = "",
    this.language = "",
    this.zip = "",
    this.address = "",
    this.city = "",
    this.lastName = "en",
    this.state = "",
  });

  Map<String, dynamic> toJson() => _$CheckoutModalToJson(this);
}

Map<String, dynamic> _$CheckoutModalToJson(CheckoutModal instance) => <String, dynamic> {
  "userid": instance.userId,
  "email": instance.email,
  "phone": instance.phone,
  "firstname": instance.firstName,
  "lastname": instance.lastName,
  "address": instance.address,
  "city": instance.city,
  "state": instance.state,
  "zip": instance.zip,
  "total": instance.total,
  "language": instance.language,
  "items": instance.items.map((item) => item.toJson()).toList().toString(),
};

class CheckoutItemModal {
  String id, quantity;
  String subTotal;

  CheckoutItemModal(this.id, this.quantity, this.subTotal);

  Map<String, dynamic> toJson() => _$itemToJson(this);
}

Map<String, dynamic> _$itemToJson(CheckoutItemModal instance) =>
    <String, dynamic>{
      "id": instance.id,
      "qty": instance.quantity,
      "subtotal": instance.subTotal,
    };
