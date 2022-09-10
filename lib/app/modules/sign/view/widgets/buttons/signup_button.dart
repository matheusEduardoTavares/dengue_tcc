import 'package:dengue_tcc/app/modules/core/widgets/default_button/default_button.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUPButton extends StatelessWidget {
  const SignUPButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      callback: () {
        Modular.to.pushNamed(
          ModulesRoute.signModuleSignUPNavigate,
        );
      },
      label: 'Registrar-se',
    );
  }
}
