import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_divider/custom_drawer_divider.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_list_tile/custom_drawer_list_tile.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_text/custom_drawer_text.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late AuthControllerInterface _controller;

  @override
  void initState() {
    super.initState();

    _controller = context.read<AuthControllerInterface>();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SafeArea(
          child: BlocConsumer<AuthControllerInterface, AuthControllerState>(
            listenWhen: (_, currentState) =>
                currentState is SuccessLogoutAuthControllerState ||
                currentState is ErrorLogoutAuthControllerState,
            listener: (context, state) async {
              if (state is ErrorLogoutAuthControllerState) {
                await AwesomeDialogsControl.showAwesomeDialogs(
                    message: state.errorMessage,
                    context: context,
                    isError: true,
                    btnOkOnPress: () {});
              } else {
                await _controller.clearLocalData();
                Modular.to.navigate(
                  Modular.initialRoute,
                );
              }
            },
            builder: (_, state) {
              if (state is LoadingLogoutAuthControllerState) {
                return const LoadingWidget();
              }

              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomDrawerText(
                        text: 'Menu',
                      ),
                    ),
                  ),
                  const CustomDrawerDivider(),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ...const [
                          CustomDrawerListTile(
                            icon: Icons.local_hospital_outlined,
                            title: 'Sintomas',
                            routeToGo: ModulesRoute.tutorialModuleNavigate,
                            arguments: 0,
                          ),
                          CustomDrawerDivider(),
                          CustomDrawerListTile(
                            icon: Icons.heart_broken_outlined,
                            title: 'Como Tratar',
                            routeToGo: ModulesRoute.tutorialModuleNavigate,
                            arguments: 1,
                          ),
                          CustomDrawerDivider(),
                          CustomDrawerListTile(
                            icon: Icons.bar_chart_outlined,
                            title: 'Gráfico',
                            routeToGo: ModulesRoute.tutorialModuleNavigate,
                            arguments: 2,
                          ),
                          CustomDrawerDivider(),
                          CustomDrawerListTile(
                            icon: Icons.error_outline,
                            title: 'Denúncias',
                            routeToGo: ModulesRoute.informationModuleNavigate,
                            arguments: InformationEnum.denunciation,
                          ),
                          CustomDrawerDivider(),
                          CustomDrawerListTile(
                            icon: Icons.campaign_outlined,
                            title: 'Campanhas',
                            routeToGo: ModulesRoute.informationModuleNavigate,
                          ),
                          CustomDrawerDivider(),
                        ],
                        CustomDrawerListTile(
                          icon: Icons.logout,
                          title: 'Sair',
                          onTap: () {
                            _controller.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
