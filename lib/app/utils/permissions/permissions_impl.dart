import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/modules/core/models/permissions/permission_status_model.dart';
import 'package:dengue_tcc/app/utils/enums/permissions/permission_status_enum.dart';
import 'package:dengue_tcc/app/utils/permissions/permissions.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsImpl implements Permissions {
  @override
  Future<PermissionStatusModel> getPermissionStatus({
    required PermissionModel permissionModel,
  }) async {
    final status = await permissionModel.permission.status;

    return PermissionStatusModel(
      permission: permissionModel,
      status: convertPermissionsType(status),
    );
  }

  PermissionStatusEnum convertPermissionsType(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.limited:
      case PermissionStatus.granted:
        return PermissionStatusEnum.enabled;
      case PermissionStatus.denied:
        return PermissionStatusEnum.denied;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        return PermissionStatusEnum.permanentlyDenied;
    }
  }

  @override
  Future<PermissionStatusModel> requestPermissions({
    required List<PermissionModel> permissions,
  }) async {
    var iterationIndex = 0;
    while (iterationIndex < permissions.length) {
      final permission = permissions[iterationIndex];

      final permissionStatus =
          await getPermissionStatus(permissionModel: permission);

      switch (permissionStatus.status) {
        case PermissionStatusEnum.enabled:
          iterationIndex++;
          continue;
        case PermissionStatusEnum.permanentlyDenied:
          return PermissionStatusModel(
            permission: permission,
            status: PermissionStatusEnum.permanentlyDenied,
          );
        case PermissionStatusEnum.denied:
          final newStatus =
              await treatDeniedPermission(deniedPermission: permission);

          if (newStatus == PermissionStatusEnum.enabled) {
            continue;
          }

          return PermissionStatusModel(
            permission: permission,
            status: newStatus,
          );
      }
    }

    return PermissionStatusModel(
      status: PermissionStatusEnum.enabled,
    );
  }

  @override
  Future<PermissionStatusEnum> treatDeniedPermission(
      {required PermissionModel deniedPermission}) async {
    final newStatus = await deniedPermission.permission.request();
    return convertPermissionsType(newStatus);
  }

  @override
  Future<bool> treatPermanentlyDeniedPermission({
    required PermissionModel permanentlyDeniedPermission,
  }) =>
      openAppSettings();
}
