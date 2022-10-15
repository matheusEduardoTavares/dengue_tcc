import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/services.dart';

enum MapMarkerEnum {
  active(status: 'Active'),
  finished(status: 'Inactive');

  final String status;

  Color get getColorBasedStatus {
    if (status == 'Active') {
      return AppColors.markerUnfinished;
    }

    return AppColors.markerFinished;
  }

  const MapMarkerEnum({
    required this.status,
  });

  static MapMarkerEnum getByType(String value) {
    final allOptions = <String, MapMarkerEnum>{};
    for (final currentMapMarkerEnum in MapMarkerEnum.values) {
      allOptions.addAll({
        currentMapMarkerEnum.status: currentMapMarkerEnum,
      });
    }

    return allOptions[value] ?? MapMarkerEnum.active;
  }
}
