import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUPPage extends StatelessWidget {
  const SignUPPage({
    required SignControllerInterface controller,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final SignControllerInterface _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SignControllerInterface, InitialSignControllerState>(
          bloc: _controller,
          builder: (_, state) {
            return const Scaffold(
              body: Center(
                child: Text('SignUPPage'),
              ),
            );
          },
        ),
      ),
    );
  }
}
