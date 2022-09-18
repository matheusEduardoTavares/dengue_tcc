import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/custom_map.dart';
import 'package:dengue_tcc/app/modules/core/widgets/permissions/permissions_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PermissionsPage(
      permissions: [
        PermissionModel(
          name: 'Localização',
          permission: Permission.location,
        ),
      ],
      builder: (_) => const CustomMap(),
    );
  }
}
