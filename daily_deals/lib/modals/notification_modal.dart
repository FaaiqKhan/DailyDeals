class NotificationModal {
  final String title, image, message, createdOn;

  NotificationModal(this.title, this.image, this.message, this.createdOn);

  factory NotificationModal.fromJson(Map<String, dynamic> json) =>
      _$NotificationModalFromJson(json);
}

NotificationModal _$NotificationModalFromJson(Map<String, dynamic> json) {
  return NotificationModal(
    json['title'],
    json['image'],
    json['message'],
    json['created_on'],
  );
}
