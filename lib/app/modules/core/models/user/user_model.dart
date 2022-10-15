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
    this.id,
  });

  final int? id;
  //Email
  final String login;
  final String? name;
  final String? password;
  final String? phone;
  final bool? isAdm;
  final String? authToken;
  final String? refreshToken;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': login,
      'senha': password,
      'telefone': phone,
      'nome': name,
      'eh_admin': isAdm,
      'authToken': authToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      login: map['email'],
      password: map['senha'],
      phone: map['telefone'],
      name: map['nome'],
      isAdm: map['eh_admin'] ?? false,
      authToken: map['authToken'],
      refreshToken: map['refreshToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
