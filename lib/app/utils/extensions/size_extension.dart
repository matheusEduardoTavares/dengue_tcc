import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  double h(double percent) => MediaQuery.of(this).size.height * (percent / 100);
  double w(double percent) => MediaQuery.of(this).size.width * (percent / 100);
}
