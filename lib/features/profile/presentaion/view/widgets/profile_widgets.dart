import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

/// Shared field label used across profile sub-screens.
class ProfileFieldLabel extends StatelessWidget {
  final String label;
  const ProfileFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(13),
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}


/// Section label used on the profile screen.
class ProfileSectionLabel extends StatelessWidget {
  final String label;
  const ProfileSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: .65),
          ),
        ),
      ),
    );
  }
}

