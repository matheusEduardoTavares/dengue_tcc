import 'package:flutter/material.dart';

class CustomAppbar extends AppBar {
  CustomAppbar({
    this.child,
    super.key,
    super.backgroundColor,
  }) : super(
          toolbarHeight: 150,
          elevation: 0,
          flexibleSpace: child,
        );

  final Widget? child;
}
