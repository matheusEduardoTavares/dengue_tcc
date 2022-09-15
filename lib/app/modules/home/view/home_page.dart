import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/custom_map.dart';
import 'package:dengue_tcc/app/modules/core/widgets/permissions/cubit/permissions_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/permissions/permissions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomMapControllerInterface>(
          create: (_) => CustomMapControllerCubit(
            environment: Modular.get(),
            customLocation: Modular.get(),
          ),
        ),
        BlocProvider<PermissionsCubit>(
          create: (context) => PermissionsCubit(
            permissions: Modular.get(),
          ),
        ),
      ],
      child: PermissionsPage(
        permissions: [
          PermissionModel(
            name: 'Localização',
            permission: Permission.location,
          ),
        ],
        builder: (_) => const CustomMap(),
      ),
    );
  }
}
