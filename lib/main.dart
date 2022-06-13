import 'package:dengue_tcc/app/app_module.dart';
import 'package:dengue_tcc/app/app_widget.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (_) => ModularApp(
        module: AppModule(), 
        child: const AppWidget(),
      ),
      //TODO sempre que precisar testar responsividade, trocar o enabled para true e após usar voltar para false (nunca commitar com enabled true)
      enabled: false,
      availableLocales: const [
        Locale('pt', 'BR'),
      ],
    ),
  );
}