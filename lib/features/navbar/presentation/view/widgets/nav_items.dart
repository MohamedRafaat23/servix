import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class NavItem extends StatelessWidget {
  final String assetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    required this.assetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: MediaQuery(
        // يمنع تكبير حجم الخط من إعدادات النظام يأثر على الـ nav bar
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 80.width : 64.width,
          padding: EdgeInsets.symmetric(vertical: 4.height),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56.height,
                height: 56.height,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1F7BFF)
                      : const Color(0xFFF0F1F3),
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF1F7BFF,
                            ).withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  assetPath,
                  width: 30.height,
                  height: 30.height,
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 4.height),
              SizedBox(
                height: 16.height, // ارتفاع ثابت لمكان النص يمنع الـ overflow
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF1F7BFF)
                        : Colors.transparent,
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w700,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}