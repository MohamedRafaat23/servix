// lib/features/home/presentation/view/widgets/professional_card.dart
import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

class ProfessionalCard extends StatelessWidget {
  final ProfessionalEntity professional;
  final VoidCallback? onTap;

  const ProfessionalCard({super.key, required this.professional, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12.width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.width,
              backgroundImage: AssetImage(professional.imageAsset),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professional.name,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.height),
                  Text(
                    '${professional.profession} · ${professional.distanceMiles} mi',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: AppColors.greyColor,
                    ),
                  ),
                  SizedBox(height: 2.height),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4.width),
                      Text(
                        '${professional.rating} · ${professional.jobsCount} Jobs',
                        style: TextStyle(fontSize: context.responsiveFontScale(12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${professional.pricePerHour.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF358BE0),
                  ),
                ),
                Text(
                  AppStrings.perHour,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}