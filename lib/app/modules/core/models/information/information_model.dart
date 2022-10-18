import 'dart:convert';

import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';

class InformationModel {
  InformationModel({
    required this.title,
    required this.date,
    required this.description,
    required this.status,
    this.id,
  });

  final int? id;
  final String title;
  final String description;
  final MapMarkerEnum status;
  final DateTime date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': title,
      'descricao': description,
      'status': status.status,
      'data_postagem': date.toIso8601String(),
    };
  }

  factory InformationModel.fromMap(Map<String, dynamic> map) {
    return InformationModel(
      id: map['id'],
      title: map['titulo'],
      description: map['descricao'],
      status: MapMarkerEnum.getByType(map['status']),
      date: map['data_postagem'],
    );
  }

  factory InformationModel.fromJson(String source) =>
      InformationModel.fromMap(json.decode(source));
}
