// lib/features/home/presentation/view/widgets/banner_page_indicator.dart
import 'package:flutter/material.dart';

class BannerPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const BannerPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF358BE0) : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}