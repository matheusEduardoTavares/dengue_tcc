import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';

class DenunciationModel extends InformationModel {
  DenunciationModel({
    required super.title,
    required super.date,
    required super.description,
    required super.status,
    super.id,
  });

  factory DenunciationModel.fromMap(Map<String, dynamic> map) {
    return DenunciationModel(
      id: map['id'],
      title: map['titulo'],
      description: map['descricao'],
      status: MapMarkerEnum.getByType(map['status']),
      date: DateTime.parse(map['data_postagem'].toString()),
    );
  }

  factory DenunciationModel.fromJson(String source) =>
      DenunciationModel.fromMap(json.decode(source));
}
