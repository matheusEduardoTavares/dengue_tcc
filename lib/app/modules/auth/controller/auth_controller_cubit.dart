import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_controller_state.dart';

class AuthControllerCubit extends AuthControllerInterface {
  AuthControllerCubit() : super(AuthControllerState.initial());
  
  @override
  Future<void> loadData() async {
    //TODO!: Adicionar o que precisa ser carregado aqui depois
    await Future.delayed(const Duration(seconds: 2));

    Modular.to.navigate(
      ModulesRoute.tutorial,
    );
  }
}
