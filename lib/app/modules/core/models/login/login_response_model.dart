import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    required this.accessToken,
    required this.name,
    required this.phone,
    this.id,
  });

  final String name;
  final String phone;
  final String accessToken;
  final int? id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'access_token': accessToken,
      'nome': name,
      'telefone': phone,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      id: int.tryParse(map['id']?.toString() ?? ''),
      accessToken: map['access_token'] ?? '',
      name: map['nome'],
      phone: map['telefone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source));
}
