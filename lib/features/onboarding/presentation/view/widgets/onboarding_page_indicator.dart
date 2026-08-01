import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  const OnboardingPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.width),
          width: currentPage == index ? 22.width : 8.width,
          height: 8.width,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primaryColor
                : AppColors.primaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.radius),
          ),
        ),
      ),
    );
  }
}