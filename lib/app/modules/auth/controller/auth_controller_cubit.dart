import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository.dart';
import 'package:dengue_tcc/app/utils/images_precache/images_precache.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_controller_state.dart';

class AuthControllerCubit extends AuthControllerInterface {
  AuthControllerCubit({
    required ImagesPrecache imagesPrecache,
    required LocalRepository localRepository,
  })  : _localRepository = localRepository,
        _imagesPrecache = imagesPrecache,
        super(AuthControllerState());

  final ImagesPrecache _imagesPrecache;
  final LocalRepository _localRepository;

  @override
  Future<void> loadData() async {
    _imagesPrecache.makeLocalImagesPrecache();

    final user = await _localRepository.getUser();
    var routeToGo = ModulesRoute.signModule;
    if (user != null) {
      emit(state.copyWith(userModel: user));
      routeToGo = ModulesRoute.home;
    }

    Modular.to.navigate(
      routeToGo,
    );
  }
}
