import 'package:dengue_tcc/app/modules/core/widgets/default_button/default_button.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatelessWidget {
  const GeneralErrorWidget({
    required this.retryCallback,
    required this.title,
    this.subTitle,
    this.buttonText,
    Key? key,
  }) : super(key: key);

  final VoidCallback retryCallback;
  final String title;
  final String? subTitle;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.inputDecorationForeground,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Icon(
                Icons.cancel,
                size: 50,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            if (subTitle != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                ),
                child: Text(
                  subTitle!,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            DefaultButton(
              callback: retryCallback,
              label: buttonText ?? 'Tentar novamente',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
