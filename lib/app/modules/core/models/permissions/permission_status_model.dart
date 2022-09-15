import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/utils/enums/permissions/permission_status_enum.dart';

class PermissionStatusModel {
  PermissionStatusModel({
    required this.status,
    this.permission,
  });

  final PermissionModel? permission;
  final PermissionStatusEnum status;
}
