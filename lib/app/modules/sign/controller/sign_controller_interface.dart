import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/core/models/login/login_model.dart';
import 'package:dengue_tcc/app/modules/sign/models/create_account_model.dart';

abstract class SignControllerInterface
    extends Cubit<InitialSignControllerState> {
  SignControllerInterface(InitialSignControllerState initialState)
      : super(initialState);

  void updateEmail(String email);
  void updatePassword(String password);
  void updateCellphone(String cellphone);
  void updateIsSignIN({
    required bool isSignIN,
  });
  void updateIsAdmin(bool isAdmin);
  Future<void> signIN(LoginModel model);
  Future<void> signUP(CreateAccountModel model);
}
