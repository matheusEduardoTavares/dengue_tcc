import 'package:dengue_tcc/app/modules/core/widgets/logo_with_text/logo_with_text.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/login_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/signup_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/sign_background/sign_background.dart';
import 'package:flutter/material.dart';

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const LogoWithText(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  LoginButton(),
                  SignUPButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
