part of 'permissions_cubit.dart';

class PermissionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingPermissionsState extends PermissionsState {}

class ErrorPermissionsState extends PermissionsState {
  final PermissionStatusModel permissionStatus;
  final bool isGoToBackgroundApp;

  ErrorPermissionsState({
    required this.permissionStatus,
    this.isGoToBackgroundApp = false,
  });

  @override
  List<Object?> get props => [permissionStatus, isGoToBackgroundApp];
}

class ErrorPermanentlyDeniedPermissionsState extends PermissionsState {
  final PermissionStatusModel permissionStatus;

  ErrorPermanentlyDeniedPermissionsState({
    required this.permissionStatus,
  });

  @override
  List<Object?> get props => [permissionStatus];
}

class ErrorWithoutConfigPermissionsState
    extends ErrorPermanentlyDeniedPermissionsState {
  ErrorWithoutConfigPermissionsState({
    required super.permissionStatus,
  });
}

class SuccessPermissionsState extends PermissionsState {}
