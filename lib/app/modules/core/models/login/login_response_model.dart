import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    required this.accessToken,
  });

  final String accessToken;

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      accessToken: map['access_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source));
}
