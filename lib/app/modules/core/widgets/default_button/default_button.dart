import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({required this.callback, required this.label, super.key});

  final String label;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          AppColors.buttonBackground,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(160, 60)),
        foregroundColor: MaterialStateProperty.all(AppColors.selectedIconBlue),
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.bodyMedium!.copyWith(
            shadows: const <Shadow>[
              Shadow(
                blurRadius: 60.0,
                color: AppColors.selectedIconBlue,
              ),
              Shadow(
                blurRadius: 60.0,
                color: AppColors.selectedIconBlue,
              ),
              Shadow(
                blurRadius: 60.0,
                color: AppColors.selectedIconBlue,
              ),
            ],
          ),
        ),
      ),
      child: Text(label),
    );
  }
}
