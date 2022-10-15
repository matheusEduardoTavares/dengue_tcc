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
      'email': login,
      'senha': password,
      'cod_admin': admCode,
      'eh_admin': isAdm,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      login: map['email'] ?? '',
      password: map['senha'] ?? '',
      admCode: map['cod_admin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));
}
