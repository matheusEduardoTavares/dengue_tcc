import 'package:dengue_tcc/app/modules/sign/modules/forgot_password/view/forgot_password_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const ForgotPasswordPage(),
    ),
  ];
}
