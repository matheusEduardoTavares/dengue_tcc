import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/dengue_appbar.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({
    required InformationControllerInterface controller,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final InformationControllerInterface _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DengueAppbar(),
      body: const Center(
        child: Text('Página em construção ...'),
      ),
    );
  }
}
