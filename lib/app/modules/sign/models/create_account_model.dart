import 'dart:convert';

class CreateAccountModel {
  CreateAccountModel({
    required this.login,
    required this.password,
    required this.phone,
    required this.name,
    this.admCode,
  });

  //Email
  final String login;
  final String name;
  final String password;
  final String phone;
  final String? admCode;

  bool get isAdm => admCode?.isNotEmpty ?? false;

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
      'phone': phone,
      'admCode': admCode,
      'name': name,
      'adm': isAdm,
    };
  }

  factory CreateAccountModel.fromMap(Map<String, dynamic> map) {
    return CreateAccountModel(
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      name: map['name'] ?? '',
      admCode: map['admCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateAccountModel.fromJson(String source) =>
      CreateAccountModel.fromMap(json.decode(source));
}
