// lib/core/widgets/app_background.dart
import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_images.dart';

/// خلفية موحدة لكل شاشات التطبيق: جراديانت بلون الـ Brand
/// + صورة خلفية شفافة فوقيه + المحتوى الفعلي فوق الاتنين.
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
    return Stack(
      children: [
        if (showImageOverlay)
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: Image.asset(
                color: AppColors.backgroundColor,
                AppImages.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        child,
      ],
    );
  }
}
