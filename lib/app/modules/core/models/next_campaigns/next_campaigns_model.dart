import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';

class NextCampaignModel extends InformationModel {
  NextCampaignModel({
    required super.description,
    required super.title,
    required super.date,
    required super.status,
    super.id,
    this.url,
  });

  final String? url;

  factory NextCampaignModel.fromMap(Map<String, dynamic> map) {
    return NextCampaignModel(
      id: (map['id'] as int?)?.toInt(),
      title: map['titulo'] ?? '',
      description: map['descricao'] ?? '',
      status: MapMarkerEnum.getByType(map['status']),
      url: map['link'],
      date: DateTime.parse(map['data_postagem'].toString()),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': title,
      'descricao': description,
      'status': status.status,
      'data_postagem': date.toIso8601String(),
      'link': url,
    };
  }

  factory NextCampaignModel.fromJson(String source) =>
      NextCampaignModel.fromMap(json.decode(source));
}
