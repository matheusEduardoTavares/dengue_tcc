import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository.dart';
import 'package:dengue_tcc/app/utils/environment/environment_impl.dart';
import 'package:dengue_tcc/app/utils/firebase_utils/firebase_utils.dart';
import 'package:dengue_tcc/app/utils/images_precache/images_precache.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_controller_state.dart';

class AuthControllerCubit extends AuthControllerInterface {
  AuthControllerCubit({
    required ImagesPrecache imagesPrecache,
    required LocalRepository localRepository,
    required AuthRepository authRepository,
  })  : _localRepository = localRepository,
        _imagesPrecache = imagesPrecache,
        _authRepository = authRepository,
        super(AuthControllerState());

  final ImagesPrecache _imagesPrecache;
  final LocalRepository _localRepository;
  final AuthRepository _authRepository;

  @override
  Future<void> loadData() async {
    await EnvironmentImpl().configureEnvironment();
    _imagesPrecache.makeLocalImagesPrecache();
    final loadDatas = await Future.wait([
      _localRepository.getUser(),
      Future.delayed(const Duration(seconds: 2)),
    ]);

    final UserModel? user = loadDatas[0];
    var routeToGo = ModulesRoute.signModule;
    if (user != null) {
      FirebaseUtils.setUserToCrashlytics(userId: user.id);
      emit(state.copyWith(userModel: user));
      routeToGo = ModulesRoute.home;
    }

    Modular.to.navigate(
      routeToGo,
    );
  }

  @override
  Future<void> updateUserModel(UserModel newModel) async {
    await saveUserLocal(newModel);
    emit(state.copyWith(
      userModel: newModel,
    ));
  }

  @override
  Future<void> saveUserLocal(UserModel user) async {
    await _localRepository.saveUser(user);
  }

  @override
  Future<void> logout() async {
    emit(LoadingLogoutAuthControllerState(
      userModel: state.userModel,
    ));

    final either = await _authRepository.logout();
    either.fold(
      (errorMessage) => emit(ErrorLogoutAuthControllerState(
        userModel: state.userModel,
        errorMessage: errorMessage,
      )),
      (_) {
        emit(SuccessLogoutAuthControllerState(
          userModel: state.userModel,
        ));
      },
    );
  }

  @override
  Future<void> clearLocalData() async {
    await _localRepository.clearLocal();
  }
}
