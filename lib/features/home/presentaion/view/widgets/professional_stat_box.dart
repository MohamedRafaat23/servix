import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfessionalStatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const ProfessionalStatBox({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.height, horizontal: 4.width),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18.radius),
          border: Border.all(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: colorScheme.primary,
              size: 22.width,
            ),
            SizedBox(height: 6.height),
            Text(
              value,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.height),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: colorScheme.onSurface.withValues(alpha: .6),
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
