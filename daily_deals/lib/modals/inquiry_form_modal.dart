class InquiryFormModal {
  String? userId, name, email, phoneNumber, subject, message;

  InquiryFormModal({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.subject,
    this.message,
  });

  Map<String, dynamic> toJson() => _$InquiryFormToJson(this);
}

Map<String, dynamic> _$InquiryFormToJson(InquiryFormModal instance) => <String, dynamic> {
  "userid": instance.userId,
  "name": instance.name,
  "email": instance.email,
  "phone": instance.phoneNumber,
  "subject": instance.subject,
  "message": instance.message,
};