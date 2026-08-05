import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants/app_images.dart';

/// Full-screen background image wrapper reused across app screens.
class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.imagePath,
    this.fit = BoxFit.cover,
  });

  final Widget child;
  final String? imagePath;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          imagePath ??
              (isDark ? AppImages.darkBackgroundImage : AppImages.backgroundImage),
          fit: fit,
          width: double.infinity,
          height: double.infinity,
        ),
        child,
      ],
    );
  }
}
