import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/denunciation/denunciation_model.dart';
import 'package:dengue_tcc/app/modules/core/models/information/informations_model.dart';

class DenunciationsModel extends InformationsModel {
  DenunciationsModel({
    required this.denunciations,
  }) : super(
          informations: denunciations,
        );

  List<DenunciationModel> denunciations;

  @override
  List<Map<String, dynamic>> toMap() {
    return denunciations.map((x) => x.toMap()).toList();
  }

  factory DenunciationsModel.fromMap(List<Map<String, dynamic>> map) {
    return DenunciationsModel(
      denunciations: map.map((x) => DenunciationModel.fromMap(x)).toList(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory DenunciationsModel.fromJson(String source) =>
      DenunciationsModel.fromMap(json.decode(source));
}
