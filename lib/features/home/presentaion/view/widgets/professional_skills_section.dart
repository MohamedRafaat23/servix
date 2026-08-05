import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'section_header_with_icon.dart';

class ProfessionalSkillsSection extends StatelessWidget {
  final List<String> skills;

  const ProfessionalSkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SectionHeaderWithIcon(
          icon: Icons.lightbulb_outline,
          title: AppStrings.skills,
        ),
        SizedBox(height: 10.height),
        Wrap(
          spacing: 8.width,
          runSpacing: 8.height,
          children: skills.map((skill) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 9.height,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(24.radius),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: context.responsiveFontScale(13),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
