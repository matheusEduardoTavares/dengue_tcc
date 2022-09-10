import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthControllerInterface>(
      create: (context) => AuthControllerCubit(
        imagesPrecache: Modular.get(),
        localRepository: Modular.get(),
      ),
      child: MaterialApp.router(
        title: 'Dengue TCC',
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
      ),
    );
  }
}
