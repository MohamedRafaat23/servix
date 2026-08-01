import 'package:flutter/material.dart';

class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  final bool isTablet;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment? crossAxisAlignment;

  const ResponsiveRowColumn({
    super.key,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize,
        children: children,
      );
    }

    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
      children: children,
    );
  }
}