import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';

abstract class AuthControllerInterface extends Cubit<AuthControllerState> {
  AuthControllerInterface(AuthControllerState initialState)
      : super(initialState);

  Future<void> clearLocalData();
  Future<void> logout();
  Future<void> loadData();
  Future<void> saveUserLocal(UserModel user);
  Future<void> updateUserModel(UserModel newModel);
}
