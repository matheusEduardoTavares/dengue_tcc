import 'dart:convert';

class LoginModel {
  LoginModel({
    required this.login,
    required this.password,
    this.admCode,
  });

  //Email
  final String login;
  final String password;
  final String? admCode;

  bool get isAdm => admCode?.isNotEmpty ?? false;

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
      'admCode': admCode,
      'adm': isAdm,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      admCode: map['admCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));
}
