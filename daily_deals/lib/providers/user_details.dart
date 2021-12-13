class UserDetails {
  String _fullName, _email, _number, _password;
  String? language, userId, rId;

  UserDetails(this._fullName, this._email, this._number, this._password,
      {this.language, this.userId});

  String get getFullName {
    return _fullName;
  }

  String get getEmail {
    return _email;
  }

  String get getNumber {
    return _number;
  }

  String get getPassword {
    return _password;
  }

  String get getLanguage {
    return language ?? "en";
  }

  String get getUserId {
    return userId ?? "";
  }

  set setFullName(String name) {
    this._fullName = name;
  }

  set setEmail(String email) {
    this._email = email;
  }

  set setNumber(String number) {
    this._number = number;
  }

  set setPassword(String password) {
    this._password = password;
  }

  set setLanguage(String lang) {
    this.language = lang;
  }

  set setUserId(String userId) {
    this.userId = userId;
  }

  set setDeviceId(String? id) {
    this.rId = id;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

Map<String, dynamic> _$UserToJson(UserDetails instance) => <String, dynamic>{
      'name': instance.getFullName,
      'email': instance.getEmail,
      'password': instance.getPassword,
      'phonenumber': instance.getNumber,
      'language': instance.getLanguage,
      'deviceToken': instance.rId ?? "",
    };
