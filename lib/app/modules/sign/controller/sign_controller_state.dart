part of 'sign_controller_cubit.dart';

class InitialSignControllerState {
  InitialSignControllerState({
    this.email = '',
    this.password = '',
    this.isAdmin = false,
    this.phone,
    this.admCode,
    this.name,
  });

  final String email;
  final String password;
  final String? admCode;
  final bool isAdmin;
  final String? phone;
  final String? name;

  InitialSignControllerState copyWith({
    String? email,
    String? password,
    bool? isAdmin,
    String? phone,
    String? admCode,
    String? name,
  }) =>
      InitialSignControllerState(
        email: email ?? this.email,
        password: password ?? this.password,
        isAdmin: isAdmin ?? this.isAdmin,
        phone: phone ?? this.phone,
        admCode: admCode ?? this.admCode,
        name: name ?? this.name,
      );
}

class SignINControllerState extends InitialSignControllerState {
  SignINControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });
}

class ErrorSignINControllerState extends SignINControllerState {
  ErrorSignINControllerState({
    required this.errorMessage,
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });

  final String errorMessage;
}

class LoadingSignINControllerState extends SignINControllerState {
  LoadingSignINControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });
}

class SuccessSignINControllerState extends SignINControllerState {
  SuccessSignINControllerState({
    required this.loginResponseModel,
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });

  final LoginResponseModel loginResponseModel;
}

class SignUPControllerState extends InitialSignControllerState {
  SignUPControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });
}

class ErrorSignUPControllerState extends SignUPControllerState {
  ErrorSignUPControllerState({
    required this.errorMessage,
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });

  final String errorMessage;
}

class LoadingSignUPControllerState extends SignUPControllerState {
  LoadingSignUPControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });
}

class SuccessSignUPControllerState extends SignUPControllerState {
  SuccessSignUPControllerState({
    super.email = '',
    super.password = '',
    super.isAdmin = false,
    super.phone,
    super.admCode,
    super.name,
  });
}
