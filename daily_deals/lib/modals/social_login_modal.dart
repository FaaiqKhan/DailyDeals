class SocialLoginModal {
  final String firstName, email;
  final String? photoUrl, lastName, accessToken;

  SocialLoginModal(
    this.firstName,
    this.lastName,
    this.email,
    this.photoUrl,
    this.accessToken,
  );

  Map<String, dynamic> toJson() => _$SocialLoginModalToJson(this);
}

Map<String, dynamic> _$SocialLoginModalToJson(SocialLoginModal instance) => <String, dynamic> {
  'firstname': instance.firstName,
  'laststname': instance.lastName ?? "",
  'email': instance.email,
  'image': instance.photoUrl ?? "",
  'deviceToken': instance.accessToken ?? "",
};