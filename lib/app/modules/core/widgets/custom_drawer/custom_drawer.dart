import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_divider/custom_drawer_divider.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_list_tile/custom_drawer_list_tile.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_text/custom_drawer_text.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
          child: Column(
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
                  children: const [
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
