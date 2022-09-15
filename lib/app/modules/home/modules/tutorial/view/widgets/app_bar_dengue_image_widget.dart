import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:flutter/material.dart';

class AppBarDengueImageWidget extends StatelessWidget {
  const AppBarDengueImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  ImagesPath.dengueAppbar,
                ),
              )
            ),
          ),
        ),
      ],
    );
  }
}