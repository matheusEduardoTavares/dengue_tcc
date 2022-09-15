import 'package:permission_handler/permission_handler.dart';

class PermissionModel {
  PermissionModel({
    required this.name,
    required this.permission,
  });

  final String name;
  final Permission permission;
}
