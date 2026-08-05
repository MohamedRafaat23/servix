import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    this.icon,
    this.image,
    required this.title,
    required this.onTap,
    this.titleColor,
  }) : assert(icon != null || image != null, 'Either icon or image must be provided.');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Widget iconWidget = icon != null
        ? Icon(icon, size: 22.width)
        : SvgPicture.asset(image!, width: 22.width, height: 22.width,);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            iconWidget,
            SizedBox(width: 12.width),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurface.withValues(alpha: .55),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
