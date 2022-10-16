import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer_text/custom_drawer_text.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile({
    required this.title,
    this.routeToGo,
    this.onTap,
    this.arguments,
    this.iconPath,
    this.icon,
    super.key,
  });

  final String? iconPath;
  final IconData? icon;
  final String title;
  final String? routeToGo;
  final Object? arguments;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ??
          () {
            Modular.to.pushNamed(
              routeToGo!,
              arguments: arguments,
            );
          },
      leading: iconPath != null
          ? Container(
              decoration: const BoxDecoration(
                boxShadow: [AppShadows.boxShadow],
              ),
              child: SvgPicture.asset(
                iconPath!,
                color: Colors.black,
              ),
            )
          : Icon(
              icon,
              color: Colors.black,
              shadows: const [
                AppShadows.drawerShador,
              ],
            ),
      title: CustomDrawerText(
        text: title,
      ),
    );
  }
}
