import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';

class NextCampaignModel extends InformationModel {
  NextCampaignModel({
    required super.information,
    required super.date,
    required this.urlCampaign,
  });

  final String urlCampaign;

  @override
  Map<String, dynamic> toMap() {
    return {
      'texto': information,
      'data': date,
      'url': urlCampaign,
    };
  }

  factory NextCampaignModel.fromMap(Map<String, dynamic> map) {
    return NextCampaignModel(
      urlCampaign: map['url'] ?? false,
      date: map['data'],
      information: map['texto'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory NextCampaignModel.fromJson(String source) =>
      NextCampaignModel.fromMap(json.decode(source));
}
