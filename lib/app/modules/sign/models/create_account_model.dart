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
      'email': login,
      'senha': password,
      'telefone': phone,
      'cod_admin': admCode,
      'nome': name,
      'eh_admin': isAdm,
    };
  }

  factory CreateAccountModel.fromMap(Map<String, dynamic> map) {
    return CreateAccountModel(
      login: map['email'] ?? '',
      password: map['senha'] ?? '',
      phone: map['telefone'] ?? '',
      name: map['nome'] ?? '',
      admCode: map['cod_admin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateAccountModel.fromJson(String source) =>
      CreateAccountModel.fromMap(json.decode(source));
}
