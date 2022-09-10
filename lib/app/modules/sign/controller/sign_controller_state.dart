part of 'sign_controller_cubit.dart';

class InitialSignControllerState {
  InitialSignControllerState({
    this.email = '',
    this.password = '',
    this.isAdmin = false,
    this.cellphone,
  });

  final String email;
  final String password;
  final bool isAdmin;
  final String? cellphone;

  InitialSignControllerState copyWith({
    String? email,
    String? password,
    bool? isAdmin,
    String? cellphone,
  }) =>
      InitialSignControllerState(
        email: email ?? this.email,
        password: password ?? this.password,
        isAdmin: isAdmin ?? this.isAdmin,
        cellphone: cellphone ?? this.cellphone,
      );
}

class SignINControllerState extends InitialSignControllerState {
  SignINControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.cellphone,
  });
}

class ErrorSignINControllerState extends SignINControllerState {
  ErrorSignINControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.cellphone,
  });
}

class SuccessSignINControllerState extends SignINControllerState {
  SuccessSignINControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.cellphone,
  });
}

class SignUPControllerState extends InitialSignControllerState {
  SignUPControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.cellphone,
  });
}

class ErrorSignUPControllerState extends SignUPControllerState {
  ErrorSignUPControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.cellphone,
  });
}

class SuccessSignUPControllerState extends SignUPControllerState {
  SuccessSignUPControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.cellphone,
  });
}
