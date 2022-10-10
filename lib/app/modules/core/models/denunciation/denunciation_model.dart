import 'dart:convert';

import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';

class DenunciationModel extends InformationModel {
  DenunciationModel({
    required super.information,
    required super.date,
    required this.isResolved,
  });

  final bool isResolved;

  @override
  Map<String, dynamic> toMap() {
    return {
      'texto': information,
      'data': date,
      'resolvido': isResolved,
    };
  }

  factory DenunciationModel.fromMap(Map<String, dynamic> map) {
    return DenunciationModel(
      isResolved: map['resolvido'] ?? false,
      date: map['data'],
      information: map['texto'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory DenunciationModel.fromJson(String source) =>
      DenunciationModel.fromMap(json.decode(source));
}
