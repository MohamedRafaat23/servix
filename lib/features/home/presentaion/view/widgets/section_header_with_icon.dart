import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class SectionHeaderWithIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeaderWithIcon({
    super.key,
    required this.icon,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20.width,
              color: colorScheme.onSurface,
            ),
            SizedBox(width: 8.width),
            Text(
              title,
              style: TextStyle(
                fontSize: context.responsiveFontScale(17),
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText!,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
