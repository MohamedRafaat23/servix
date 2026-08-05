import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';
import 'professional_stat_box.dart';

class ProfessionalHeaderCard extends StatelessWidget {
  final ProfessionalEntity professional;

  const ProfessionalHeaderCard({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 46.width,
              backgroundImage: AssetImage(professional.imageAsset),
            ),
          ),
          SizedBox(height: 12.height),
          // Professional Name
          Text(
            professional.name,
            style: TextStyle(
              fontSize: context.responsiveFontScale(20),
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.height),
          // Profession & Distance
          Text(
            '${professional.profession} · ${professional.distanceMiles} mi',
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: colorScheme.onSurface.withValues(alpha: .65),
            ),
          ),
          SizedBox(height: 6.height),
          // Rating & Jobs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16.width,
              ),
              SizedBox(width: 4.width),
              Text(
                '${professional.rating} · ${professional.jobsCount} Jobs',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colorScheme.onSurface.withValues(alpha: .65),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.height),
          // 3 Stat Boxes
          Row(
            children: [
              ProfessionalStatBox(
                icon: Icons.work_outline,
                value: '${professional.jobsCount}',
                label: AppStrings.jobs,
              ),
              SizedBox(width: 8.width),
              ProfessionalStatBox(
                icon: Icons.verified_outlined,
                value: '${professional.experiance} yrs',
                label: AppStrings.experience,
              ),
              SizedBox(width: 8.width),
              ProfessionalStatBox(
                icon: Icons.location_on_outlined,
                value: '${professional.serviceAreaCount}',
                label: AppStrings.serviceArea,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
