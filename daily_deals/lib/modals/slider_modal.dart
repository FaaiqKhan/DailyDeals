class SliderModal {
  final String? id, photo, title, buttonTitle;

  SliderModal({
    this.id,
    this.photo,
    this.title,
    this.buttonTitle,
  });

  factory SliderModal.fromJson(Map<String, dynamic> json) =>
      _$SliderFromJson(json);
}

SliderModal _$SliderFromJson(Map<String, dynamic> json) {
  return SliderModal(
    id: json['id'],
    photo: json['photo'],
    title: json['title'],
    buttonTitle: json['button_title'],
  );
}
