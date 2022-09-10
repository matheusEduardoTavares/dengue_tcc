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
