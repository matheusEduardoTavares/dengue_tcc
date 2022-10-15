import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    required this.accessToken,
    required this.name,
    required this.phone,
  });

  final String accessToken;
  final String name;
  final String phone;

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'nome': name,
      'telefone': phone,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      accessToken: map['access_token'] ?? '',
      name: map['nome'],
      phone: map['telefone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source));
}
