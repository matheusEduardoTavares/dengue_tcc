import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/utils/images_precache/images_precache.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_controller_state.dart';

class AuthControllerCubit extends AuthControllerInterface {
  AuthControllerCubit({
    required ImagesPrecache imagesPrecache,
  }) : 
  _imagesPrecache = imagesPrecache,
  super(AuthControllerState.initial());

  final ImagesPrecache _imagesPrecache;
  
  @override
  Future<void> loadData() async {
    _imagesPrecache.makeLocalImagesPrecache();
    
    //TODO!: Adicionar o que precisa ser carregado aqui depois
    await Future.delayed(const Duration(seconds: 2));

    Modular.to.navigate(
      ModulesRoute.tutorial,
    );
  }  
}
