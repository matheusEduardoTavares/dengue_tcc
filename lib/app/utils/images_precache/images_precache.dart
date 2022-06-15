import 'package:flutter/widgets.dart';

abstract class ImagesPrecache {
  void makeLocalImagesPrecache({
    List<String> images, 
    BuildContext? context,
  });
}