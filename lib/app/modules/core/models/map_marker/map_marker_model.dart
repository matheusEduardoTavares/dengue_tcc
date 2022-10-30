import 'dart:convert';

import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';

class MapMarkerModel {
  MapMarkerModel({
    required this.status,
    required this.latLngModel,
    this.counter = 1,
    this.title,
    this.description,
    this.id,
    this.userID,
    this.finishedDate,
  });

  final int? id;
  final String? title;
  final String? description;
  final MapMarkerEnum status;
  final CustomLatLngModel latLngModel;
  final int? userID;
  final int counter;
  final DateTime? finishedDate;

  bool get isCreatedMarker => id != null;

  Map<String, dynamic> toMap({
    bool isSendMarkersQuantity = true,
  }) {
    return {
      'id': id,
      'titulo': title,
      'descricao': description,
      'status': status.status,
      'latitude': latLngModel.lat,
      'longitude': latLngModel.lon,
      'usuario_id': userID,
      'data_finalizado': finishedDate?.toIso8601String(),
      if (isSendMarkersQuantity) 'qtd_alertas': counter,
    };
  }

  factory MapMarkerModel.fromMap(Map<String, dynamic> map) {
    return MapMarkerModel(
      id: map['id'],
      title: map['titulo'],
      description: map['descricao'],
      status: MapMarkerEnum.getByType(map['status']),
      userID: map['usuario_id'],
      counter: map['qtd_alertas'] ?? 1,
      finishedDate: DateTime.tryParse(map['data_finalizado']?.toString() ?? ''),
      latLngModel: CustomLatLngModel(
        lat: double.parse(map['latitude'].toString()),
        lon: double.parse(map['longitude'].toString()),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapMarkerModel.fromJson(String source) =>
      MapMarkerModel.fromMap(json.decode(source));

  MapMarkerModel copyWith({
    int? id,
    String? title,
    String? description,
    MapMarkerEnum? status,
    CustomLatLngModel? latLngModel,
    int? counter,
    int? userID,
    DateTime? finishedDate,
  }) {
    return MapMarkerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      latLngModel: latLngModel ?? this.latLngModel,
      counter: counter ?? this.counter,
      userID: userID ?? this.userID,
      finishedDate: finishedDate ?? this.finishedDate,
    );
  }

  MapMarkerModel nullify({
    bool? id,
    bool? title,
    bool? description,
    bool? finishedDate,
  }) {
    return MapMarkerModel(
      id: id ?? false ? null : this.id,
      title: title ?? false ? null : this.title,
      description: description ?? false ? null : this.description,
      finishedDate: finishedDate ?? false ? null : this.finishedDate,
      status: status,
      latLngModel: latLngModel,
      counter: counter,
      userID: userID,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapMarkerModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.latLngModel == latLngModel &&
        other.userID == userID &&
        other.counter == counter &&
        other.finishedDate == finishedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode ^
        latLngModel.hashCode ^
        userID.hashCode ^
        counter.hashCode ^
        finishedDate.hashCode;
  }
}
