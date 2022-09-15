import 'package:flutter/material.dart';

class CustomDrawerDivider extends StatelessWidget {
  const CustomDrawerDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Divider(
        color: Colors.black,
        thickness: 2,
      ),
    );
  }
}
