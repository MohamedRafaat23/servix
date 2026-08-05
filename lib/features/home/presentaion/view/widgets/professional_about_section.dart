import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'section_header_with_icon.dart';

class ProfessionalAboutSection extends StatelessWidget {
  final String aboutText;

  const ProfessionalAboutSection({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SectionHeaderWithIcon(
          icon: Icons.info_outline,
          title: AppStrings.about,
        ),
        SizedBox(height: 8.height),
        Text(
          aboutText,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13.5),
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .7),
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
