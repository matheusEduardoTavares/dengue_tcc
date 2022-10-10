import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/information/informations_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaigns_model.dart';

class NextCampaignsModel extends InformationsModel {
  NextCampaignsModel({
    required this.campaigns,
  }) : super(
          informations: campaigns,
        );

  List<NextCampaignModel> campaigns;

  @override
  List<Map<String, dynamic>> toMap() {
    return campaigns.map((x) => x.toMap()).toList();
  }

  factory NextCampaignsModel.fromMap(List<Map<String, dynamic>> map) {
    return NextCampaignsModel(
      campaigns: map.map((x) => NextCampaignModel.fromMap(x)).toList(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory NextCampaignsModel.fromJson(String source) =>
      NextCampaignsModel.fromMap(json.decode(source));
}
