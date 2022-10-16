import 'package:dengue_tcc/app/modules/core/models/map_marker/map_marker_model.dart';
import 'package:dengue_tcc/app/utils/icons_path/icons_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapMarkerWidget extends StatelessWidget {
  const MapMarkerWidget({
    this.marker,
    this.color,
    Key? key,
  }) : super(key: key);

  final MapMarkerModel? marker;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsPath.mapMarker,
      color: marker?.status.getColorBasedStatus ?? color,
    );
  }
}
