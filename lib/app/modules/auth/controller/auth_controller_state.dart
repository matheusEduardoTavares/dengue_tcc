part of 'auth_controller_cubit.dart';

class AuthControllerState {
  AuthControllerState({
    this.userModel,
  });

  final UserModel? userModel;

  AuthControllerState copyWith({
    UserModel? userModel,
  }) {
    return AuthControllerState(
      userModel: userModel ?? this.userModel,
    );
  }
}

class LoadingLogoutAuthControllerState extends AuthControllerState {
  LoadingLogoutAuthControllerState({
    required super.userModel,
  });
}

class ErrorLogoutAuthControllerState extends AuthControllerState {
  ErrorLogoutAuthControllerState({
    required super.userModel,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  AuthControllerState copyWith({UserModel? userModel, String? errorMessage}) {
    return ErrorLogoutAuthControllerState(
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SuccessLogoutAuthControllerState extends AuthControllerState {
  SuccessLogoutAuthControllerState({
    required super.userModel,
  });
}
