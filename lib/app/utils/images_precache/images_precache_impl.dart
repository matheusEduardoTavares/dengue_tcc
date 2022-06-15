import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:dengue_tcc/app/utils/images_precache/images_precache.dart';
import 'package:dengue_tcc/app/utils/navigator_service/navigator_service.dart';
import 'package:flutter/widgets.dart';

class ImagesPrecacheImpl implements ImagesPrecache {
  @override
  void makeLocalImagesPrecache({
    List<String> images = imagesToMakePrecache,
    BuildContext? context,
  }) {
    for (final currentImage in images) {
      precacheImage(
        AssetImage(currentImage), 
        context ?? NavigatorService.globalBuildContext,
      );
    }
  }
  
  static const imagesToMakePrecache = [
    ImagesPath.logo,
    ImagesPath.dengueAppbar,
    ImagesPath.dengueFight,
    ImagesPath.dengueGraphic,
    ImagesPath.dengueSymptons,
  ];
}