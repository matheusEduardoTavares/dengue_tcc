import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';

abstract class SignControllerInterface
    extends Cubit<InitialSignControllerState> {
  SignControllerInterface(InitialSignControllerState initialState)
      : super(initialState);

  void updateEmail(String email);
  void updatePassword(String password);
  void updateCellphone(String phone);
  void updateIsSignIN({
    required bool isSignIN,
  });
  void updateIsAdmin(bool isAdmin);
  void updateAdmCode(String admCode);
  Future<void> signIN();
  Future<void> signUP();
  void errorCallbackState();
  void clearState();
}
