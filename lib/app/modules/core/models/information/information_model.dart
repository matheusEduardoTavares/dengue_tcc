import 'dart:convert';

class InformationModel {
  InformationModel({
    required this.information,
    required this.date,
  });

  final String information;
  final String date;

  Map<String, dynamic> toMap() {
    return {
      'text': information,
      'data': date,
    };
  }

  factory InformationModel.fromMap(Map<String, dynamic> map) {
    return InformationModel(
      date: map['data'],
      information: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InformationModel.fromJson(String source) =>
      InformationModel.fromMap(json.decode(source));
}
