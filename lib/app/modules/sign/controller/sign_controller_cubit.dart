import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/models/login/login_model.dart';
import 'package:dengue_tcc/app/modules/sign/models/create_account_model.dart';
import 'package:dengue_tcc/app/modules/sign/repositories/signup_repository.dart';

part 'sign_controller_state.dart';

class SignControllerCubit extends SignControllerInterface {
  SignControllerCubit({
    required AuthRepository authRepository,
    required SignupRepository signupRepository,
  })  : _signupRepository = signupRepository,
        _authRepository = authRepository,
        super(SignINControllerState());

  final AuthRepository _authRepository;
  final SignupRepository _signupRepository;

  @override
  Future<void> signIN(LoginModel model) async {
    final either = await _authRepository.login(model: model);
    either.fold(
      (l) => emit(ErrorSignINControllerState(
        cellphone: state.cellphone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
      )),
      (r) => emit(SuccessSignINControllerState(
        cellphone: state.cellphone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
      )),
    );
  }

  @override
  Future<void> signUP(CreateAccountModel model) async {
    final either = await _signupRepository.createAccount(model: model);
    either.fold(
      (l) => emit(ErrorSignUPControllerState(
        cellphone: state.cellphone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
      )),
      (r) => emit(SuccessSignUPControllerState(
        cellphone: state.cellphone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
      )),
    );
  }

  @override
  void updateCellphone(String cellphone) {
    emit(state.copyWith(
      cellphone: cellphone,
    ));
  }

  @override
  void updateEmail(String email) {
    emit(state.copyWith(
      email: email,
    ));
  }

  @override
  void updateIsAdmin(bool isAdmin) {
    emit(state.copyWith(
      isAdmin: isAdmin,
    ));
  }

  @override
  void updateIsSignIN({
    required bool isSignIN,
  }) {
    if (isSignIN) {
      emit(SignINControllerState(
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        cellphone: state.cellphone,
      ));
    } else {
      emit(SignUPControllerState(
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        cellphone: state.cellphone,
      ));
    }
  }

  @override
  void updatePassword(String password) {
    emit(state.copyWith(
      password: password,
    ));
  }
}
