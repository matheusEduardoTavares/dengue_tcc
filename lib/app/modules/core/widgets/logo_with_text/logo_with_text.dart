import 'package:dengue_tcc/app/utils/extensions/size_extension.dart';
import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:flutter/widgets.dart';

class LogoWithText extends StatelessWidget {
  const LogoWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset(
        ImagesPath.logoWithText,
        height: context.h(25),
        width: context.w(40),
        fit: BoxFit.fill,
      ),
    );
  }
}
