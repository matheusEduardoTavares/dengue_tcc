import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/modules/core/models/permissions/permission_status_model.dart';
import 'package:dengue_tcc/app/utils/enums/permissions/permission_status_enum.dart';
import 'package:dengue_tcc/app/utils/permissions/permissions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  final Permissions _permissions;

  PermissionsCubit({
    required Permissions permissions,
  })  : _permissions = permissions,
        super(PermissionsState());

  Future<void> requestPermissions({
    required List<PermissionModel> permissions,
  }) async {
    emit(LoadingPermissionsState());

    final permissionStatus = await _permissions.requestPermissions(
      permissions: permissions,
    );

    switch (permissionStatus.status) {
      case PermissionStatusEnum.enabled:
        emit(SuccessPermissionsState());
        break;
      case PermissionStatusEnum.permanentlyDenied:
        emit(ErrorPermanentlyDeniedPermissionsState(
          permissionStatus: permissionStatus,
        ));
        break;
      case PermissionStatusEnum.denied:
        emit(
          ErrorPermissionsState(
            permissionStatus: permissionStatus,
          ),
        );
    }
  }

  Future<void> executePermanentlyPermission({
    required List<PermissionModel> permissions,
  }) async {
    final currentState = state as ErrorPermanentlyDeniedPermissionsState;

    emit(LoadingPermissionsState());

    final canOpenSettings = await _permissions.treatPermanentlyDeniedPermission(
      permanentlyDeniedPermission: currentState.permissionStatus.permission!,
    );

    if (!canOpenSettings) {
      emit(ErrorWithoutConfigPermissionsState(
        permissionStatus: currentState.permissionStatus,
      ));
    } else {
      emit(
        ErrorPermissionsState(
          permissionStatus: currentState.permissionStatus,
          isGoToBackgroundApp: true,
        ),
      );
    }
  }
}
