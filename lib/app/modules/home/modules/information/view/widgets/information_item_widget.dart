import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:flutter/material.dart';

class InformationItemWidget extends StatelessWidget {
  const InformationItemWidget({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          AppShadows.informationItemShadow,
        ],
        color: Colors.grey[400],
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}
