import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigatorService {
  NavigatorService._();

  static final navigatorKey = Modular.routerDelegate.navigatorKey;  
  static BuildContext get globalBuildContext => 
    navigatorKey.currentState!.context;
}