import 'dart:convert';

class InformationModel {
  InformationModel({
    required this.informations,
  });

  final List<String> informations;

  Map<String, dynamic> toMap() {
    return {
      'informations': informations,
    };
  }

  factory InformationModel.fromMap(Map<String, dynamic> map) {
    return InformationModel(
      informations: List<String>.from(map['informations']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InformationModel.fromJson(String source) =>
      InformationModel.fromMap(json.decode(source));
}
