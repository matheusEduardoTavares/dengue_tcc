import 'package:dengue_tcc/app/app_module.dart';
import 'package:dengue_tcc/app/app_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(), 
      child: const AppWidget(),
    ),
  );
}