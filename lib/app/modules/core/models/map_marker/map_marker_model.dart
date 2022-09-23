import 'dart:convert';

import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';

class MapMarkerModel {
  MapMarkerModel({
    required this.status,
    required this.latLngModel,
    this.title,
    this.description,
    this.id,
  });

  final String? id;
  final String? title;
  final String? description;
  final MapMarkerEnum status;
  final CustomLatLngModel latLngModel;

  bool get isCreatedMarker =>
      (title?.isNotEmpty ?? false) || (description?.isNotEmpty ?? false);
  bool get isAPIMarker => id?.isNotEmpty ?? false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.status,
      'latitude': latLngModel.lat,
      'longitude': latLngModel.lon,
    };
  }

  factory MapMarkerModel.fromMap(Map<String, dynamic> map) {
    return MapMarkerModel(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: MapMarkerEnum.getByType(map['status']),
      latLngModel: CustomLatLngModel(
        lat: double.parse(map['latitude']),
        lon: double.parse(map['longitude']),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapMarkerModel.fromJson(String source) =>
      MapMarkerModel.fromMap(json.decode(source));

  MapMarkerModel copyWith({
    String? id,
    String? title,
    String? description,
    MapMarkerEnum? status,
    CustomLatLngModel? latLngModel,
  }) {
    return MapMarkerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      latLngModel: latLngModel ?? this.latLngModel,
    );
  }
}
