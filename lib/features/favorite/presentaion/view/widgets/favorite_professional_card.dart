import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

class FavoriteProfessionalCard extends StatelessWidget {
  final ProfessionalEntity professional;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final bool showOnlineDot;

  const FavoriteProfessionalCard({
    super.key,
    required this.professional,
    this.onTap,
    this.onFavoriteToggle,
    this.showOnlineDot = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: EdgeInsets.only(top: 8.height, right: 8.width),
            padding: EdgeInsets.symmetric(
              horizontal: 14.width,
              vertical: 14.height,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with online status indicator
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28.width,
                      backgroundImage: AssetImage(professional.imageAsset),
                    ),
                    if (showOnlineDot)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12.width,
                          height: 12.width,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 14.width),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        professional.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(15),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 3.height),
                      Text(
                        '${professional.profession} · ${professional.distanceMiles} mi',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(width: 3.width),
                          Text(
                            '${professional.rating} - ${professional.jobsCount} Jobs',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(12),
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.width),
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12.height),
                    Text(
                      '\$${professional.pricePerHour.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
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
                SizedBox(width: 12.width),
              ],
            ),
          ),
        ),
        // Top right favorite heart button
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              padding: EdgeInsets.all(7.width),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Color(0xFFEF4444),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
