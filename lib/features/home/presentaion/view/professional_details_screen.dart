import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

import 'widgets/professional_about_section.dart';
import 'widgets/professional_bottom_bar.dart';
import 'widgets/professional_header_card.dart';
import 'widgets/professional_reviews_section.dart';
import 'widgets/professional_skills_section.dart';

class ProfessionalDetailsScreen extends StatelessWidget {
  final ProfessionalEntity professional;

  const ProfessionalDetailsScreen({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    final List<String> defaultSkills = const [
      'Emergency Repair',
      'Installation',
      'Inspection',
      'Maintenance',
      'Consultation',
    ];

    final skillsList = professional.skills ?? defaultSkills;
    final aboutText = professional.about ??
        '${professional.name.split(' ').first} has served the Brooklyn area for over ${professional.experiance} years, specializing in ${professional.profession.toLowerCase()} with a focus on residential jobs. Fully licensed, insured, and background-checked.';

    return Scaffold(
      backgroundColor: const Color(0xFFEBF3FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: context.responsiveFontScale(18),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Color(0xFFEF4444)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF334155)),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                AppImages.backgroundImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 12.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfessionalHeaderCard(professional: professional),
                SizedBox(height: 22.height),
                ProfessionalAboutSection(aboutText: aboutText),
                SizedBox(height: 22.height),
                ProfessionalSkillsSection(skills: skillsList),
                SizedBox(height: 22.height),
                ProfessionalReviewsSection(
                  reviews: professional.reviews,
                  onSeeAllTap: () {},
                ),
                SizedBox(height: 100.height),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: ProfessionalBottomBar(
        pricePerHour: professional.pricePerHour,
        onCallTap: () {},
        onBookTap: () {},
      ),
    );
  }
}
