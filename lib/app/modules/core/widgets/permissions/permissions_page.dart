import 'package:dengue_tcc/app/modules/core/models/permissions/permission_model.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/dengue_appbar.dart';
import 'package:dengue_tcc/app/modules/core/widgets/general_error/general_error_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/permissions/cubit/permissions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({
    required this.builder,
    required this.permissions,
    this.initState,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;
  final List<PermissionModel> permissions;
  final VoidCallback? initState;

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage>
    with WidgetsBindingObserver {
  late PermissionsCubit _cubit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _cubit = context.read<PermissionsCubit>()
      ..requestPermissions(
        permissions: widget.permissions,
      );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final cubitState = _cubit.state;
      if (cubitState is ErrorPermissionsState &&
          cubitState.isGoToBackgroundApp) {
        _cubit.requestPermissions(
          permissions: widget.permissions,
        );
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionsCubit, PermissionsState>(
      bloc: _cubit,
      listener: (_, state) {
        if (state is SuccessPermissionsState) {
          widget.initState?.call();
        }
      },
      builder: (_, state) => Scaffold(
        appBar: state is! SuccessPermissionsState ? DengueAppbar() : null,
        body: Builder(
          builder: (context) {
            if (state is LoadingPermissionsState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is ErrorPermissionsState ||
                state is ErrorPermanentlyDeniedPermissionsState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GeneralErrorWidget(
                  retryCallback: () {
                    if (state is ErrorPermanentlyDeniedPermissionsState) {
                      _cubit.executePermanentlyPermission(
                        permissions: widget.permissions,
                      );
                    } else {
                      _cubit.requestPermissions(
                        permissions: widget.permissions,
                      );
                    }
                  },
                  title: 'Erro de permissões',
                  subTitle:
                      'É necessário aceitar todas permissões para poder prosseguir',
                ),
              );
            }

            if (state is ErrorWithoutConfigPermissionsState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GeneralErrorWidget(
                  retryCallback: () {
                    _cubit.requestPermissions(
                      permissions: widget.permissions,
                    );
                  },
                  title: 'Erro de permissões',
                  subTitle:
                      'É necessário entrar nas configurações deste aplicativo e '
                      'aceitar todas permissões para poder prosseguir',
                ),
              );
            }

            return widget.builder(context);
          },
        ),
      ),
    );
  }
}
