class CheckoutModal {
  String userId, email, phone, firstName, addressType;
  String? zip, language, lastName, address, city, state;
  String total;
  List<CheckoutItemModal> items;

  CheckoutModal(
    this.userId,
    this.email,
    this.phone,
    this.firstName,
    this.total,
    this.items,
    this.addressType,
  );

  Map<String, dynamic> toJson() => _$CheckoutModalToJson(this);
}

Map<String, dynamic> _$CheckoutModalToJson(CheckoutModal instance) =>
    <String, dynamic>{
      "userid": instance.userId,
      "email": instance.email,
      "phone": instance.phone,
      "firstname": instance.firstName,
      "lastname": "khan",
      "address": instance.address ?? "",
      "city": instance.city ?? "",
      "state": instance.state ?? "",
      "zip": instance.zip ?? "",
      "total": instance.total,
      "language": "en",
      "address_type": instance.addressType,
      "items": instance.items.map((item) => item.toJson()).toList(),
    };

class CheckoutItemModal {
  String id, quantity, subTotal;
  List<CodeSequence> sequence;
  int dealType;

  CheckoutItemModal(
    this.id,
    this.quantity,
    this.subTotal,
    this.dealType,
    this.sequence,
  );

  Map<dynamic, dynamic> toJson() => _$itemToJson(this);
}

Map<dynamic, dynamic> _$itemToJson(CheckoutItemModal instance) =>
    <dynamic, dynamic>{
      "id": instance.id,
      "qty": instance.quantity,
      "subtotal": instance.subTotal,
      "deal_type": instance.dealType,
      "code_sequence": instance.sequence.map((e) => e.toJson()).toList(),
    };

class CodeSequence {
  List<dynamic>? sequence;
  String donationType;

  CodeSequence(this.donationType, {this.sequence});

  Map<dynamic, dynamic> toJson() => _$SequenceToJson(this);
}

Map<dynamic, dynamic> _$SequenceToJson(CodeSequence instance) => <dynamic, dynamic> {
  "sequence": instance.sequence,
  "donation_type": instance.donationType,
};