import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/modules/core/models/permissions/permission_status_model.dart';
import 'package:dengue_tcc/app/utils/enums/permissions/permission_status_enum.dart';

abstract class Permissions {
  Future<PermissionStatusModel> getPermissionStatus({
    required PermissionModel permissionModel,
  });

  Future<PermissionStatusModel> requestPermissions({
    required List<PermissionModel> permissions,
  });

  Future<PermissionStatusEnum> treatDeniedPermission({
    required PermissionModel deniedPermission,
  });

  //the bool return show if device can use any resource to open app configs, avoiding manually open
  Future<bool> treatPermanentlyDeniedPermission({
    required PermissionModel permanentlyDeniedPermission,
  });
}
