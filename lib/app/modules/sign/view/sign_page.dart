import 'package:dengue_tcc/app/modules/core/widgets/logo_with_text/logo_with_text.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/login_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/signup_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/sign_background/sign_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignPage extends StatelessWidget {
  const SignPage({
    required SignControllerInterface controller,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final SignControllerInterface _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignBackground(
        child: SafeArea(
          child:
              BlocBuilder<SignControllerInterface, InitialSignControllerState>(
            bloc: _controller,
            builder: (_, state) {
              return Column(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
