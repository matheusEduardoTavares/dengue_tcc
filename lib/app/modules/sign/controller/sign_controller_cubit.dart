import 'package:dengue_tcc/app/modules/core/models/login/login_response_model.dart';
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
  Future<void> signIN() async {
    emit(LoadingSignINControllerState(
      phone: state.phone,
      email: state.email,
      isAdmin: state.isAdmin,
      password: state.password,
      admCode: state.admCode,
      name: state.name,
    ));

    final model = LoginModel(
      login: state.email,
      password: state.password,
      admCode: state.admCode,
    );

    final either = await _authRepository.login(model: model);
    either.fold(
      (errorMessage) => emit(ErrorSignINControllerState(
        phone: state.phone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        admCode: state.admCode,
        name: state.name,
        errorMessage: errorMessage,
      )),
      (loginResponseModel) => emit(SuccessSignINControllerState(
        phone: state.phone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        admCode: state.admCode,
        name: state.name,
        loginResponseModel: loginResponseModel,
      )),
    );
  }

  @override
  Future<void> signUP() async {
    emit(LoadingSignUPControllerState(
      phone: state.phone,
      email: state.email,
      isAdmin: state.isAdmin,
      password: state.password,
      admCode: state.admCode,
      name: state.name,
    ));

    final model = CreateAccountModel(
      login: state.email,
      password: state.password,
      admCode: state.admCode,
      name: state.name!,
      phone: state.phone!,
    );

    final either = await _signupRepository.createAccount(model: model);
    either.fold(
      (errorMessage) => emit(ErrorSignUPControllerState(
        phone: state.phone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        admCode: state.admCode,
        name: state.name,
        errorMessage: errorMessage,
      )),
      (r) => emit(SuccessSignUPControllerState(
        phone: state.phone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        admCode: state.admCode,
        name: state.name,
      )),
    );
  }

  @override
  void updateCellphone(String phone) {
    emit(state.copyWith(
      phone: phone,
    ));
  }

  @override
  void updateEmail(String email) {
    emit(state.copyWith(
      email: email,
    ));
  }

  @override
  void updateName(String name) {
    emit(state.copyWith(
      name: name,
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
        phone: state.phone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        admCode: state.admCode,
        name: state.name,
      ));
    } else {
      emit(SignUPControllerState(
        phone: state.phone,
        email: state.email,
        isAdmin: state.isAdmin,
        password: state.password,
        admCode: state.admCode,
        name: state.name,
      ));
    }
  }

  @override
  void updatePassword(String password) {
    emit(state.copyWith(
      password: password,
    ));
  }

  @override
  void updateAdmCode(String admCode) {
    emit(state.copyWith(
      admCode: admCode,
    ));
  }

  @override
  void setErrorSignINState() {
    emit(SignINControllerState(
      phone: state.phone,
      email: state.email,
      isAdmin: state.isAdmin,
      password: state.password,
      admCode: state.admCode,
      name: state.name,
    ));
  }

  @override
  void setErrorSignUPState() {
    emit(SignUPControllerState(
      phone: state.phone,
      email: state.email,
      isAdmin: state.isAdmin,
      password: state.password,
      admCode: state.admCode,
      name: state.name,
    ));
  }

  @override
  void clearState() {
    emit(InitialSignControllerState());
  }
}
