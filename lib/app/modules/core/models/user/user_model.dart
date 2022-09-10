import 'dart:convert';

class UserModel {
  UserModel({
    required this.login,
    required this.password,
    required this.phone,
    required this.name,
    required this.authToken,
    required this.refreshToken,
    this.isAdm = false,
  });

  //Email
  final String login;
  final String name;
  final String password;
  final String phone;
  final bool? isAdm;
  final String authToken;
  final String refreshToken;

  Map<String, dynamic> toMap() {
    return {
      'text': {
        'login': login,
        'password': password,
        'phone': phone,
        'name': name,
        'adm': isAdm,
        'authToken': authToken,
        'refreshToken': refreshToken,
      }
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      name: map['name'] ?? '',
      isAdm: map['adm'] ?? false,
      authToken: map['authToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
