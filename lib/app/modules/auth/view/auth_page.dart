import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    required AuthControllerInterface controller,
    Key? key
  }) : 
  _controller = controller,
  super(key: key);

  // ignore: unused_field
  final AuthControllerInterface _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImagesPath.logo
        ),
      ),
    );
  }
}