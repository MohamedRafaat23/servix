// lib/core/widgets/app_background.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servix/core/utils/constants/app_images.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool showImageOverlay;

  const AppBackground({
    super.key,
    required this.child,
    this.showImageOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: isDark ? const Color(0xFF0A1929) : const Color(0xFFF7FAFD),
      child: Stack(
        children: [
          if (showImageOverlay)
            Positioned.fill(
              child: SvgPicture.asset(
                isDark ? AppImages.darkBackgroundImage : AppImages.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          child,
        ],
      ),
    );
  }
}