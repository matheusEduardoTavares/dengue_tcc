import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';

class InformationsModel {
  InformationsModel({
    required this.informations,
  });

  final List<InformationModel> informations;

  List<Map<String, dynamic>> toMap() {
    return informations.map((x) => x.toMap()).toList();
  }

  factory InformationsModel.fromMap(List<Map<String, dynamic>> map) {
    return InformationsModel(
      informations: map.map((x) => InformationModel.fromMap(x)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory InformationsModel.fromJson(String source) =>
      InformationsModel.fromMap(json.decode(source));
}
