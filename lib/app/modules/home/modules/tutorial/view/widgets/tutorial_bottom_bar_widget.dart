import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/icons_path/icons_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TutorialBottomBarWidget extends StatelessWidget {
  const TutorialBottomBarWidget({
    required this.selectedBottomNavigatorBarIndex,
    required this.onTap,
    Key? key
  }) : super(key: key);

  final int selectedBottomNavigatorBarIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomBarBlack,
        borderRadius: BorderRadius.circular(18),
      ),
      height: 43,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox.shrink(),
          ...[
            IconsPath.alert,
            IconsPath.notification,
            IconsPath.statistics,
          ].asMap().map(
            (index, currentPath) {
              final isSelected = selectedBottomNavigatorBarIndex == index;
              return MapEntry(
                index, 
                GestureDetector(
                  onTap: onTap != null ? () => onTap!(index) : null,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: AppColors.selectedIconBlue.withOpacity(0.2),
                            blurRadius: 10,
                          ),
                      ]
                    ),
                    child: SvgPicture.asset(
                      currentPath,
                      fit: BoxFit.contain,
                      color: isSelected ? AppColors.selectedIconBlue : 
                        AppColors.unselectedIconPurple,
                    ),
                  ),
                ),
              );
            },
          ).values.toList(),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}