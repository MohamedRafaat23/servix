import 'package:flutter/material.dart';

import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/card_cutout_painter.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

class ProfessionalCard extends StatelessWidget {
  final ProfessionalEntity professional;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavoritesCard;
  final bool isFavorite; 
  final bool showOnlineDot;

  const ProfessionalCard({
    super.key,
    required this.professional,
    this.onTap,
    this.onFavoriteToggle,
    this.isFavoritesCard = false,
    this.isFavorite = false, 
    this.showOnlineDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double buttonSize = 36.width;
    final double buttonRadius = buttonSize / 2;
    final double cutoutGap = 5.width;

    final double buttonTop = 0;
    final double buttonRight = 6.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.height, horizontal: 4.width),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: CardCutoutPainter(
                  color: colorScheme.surface,
                  buttonRight: buttonRight,
                  buttonTop: buttonTop,
                  buttonRadius: buttonRadius,
                  cutoutGap: cutoutGap,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 14.width,
                right: buttonRight + buttonSize + 4.width,
                top: 12.height,
                bottom: 12.height,
              ),
              child: Row(
                children: [
                  // الصورة الشخصية
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 56.width,
                        height: 56.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(professional.imageAsset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (showOnlineDot)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 14.width,
                            height: 14.width,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 12.width),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          professional.name,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.height),
                        Text(
                          '${professional.profession} · ${professional.distanceMiles} mi',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            fontWeight: FontWeight.w400,
                            color: colorScheme.onSurface.withValues(alpha: .62),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.height),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFF7CE45),
                              size: 14,
                            ),
                            SizedBox(width: 2.width),
                            Text(
                              '${professional.rating} · ${professional.jobsCount} jobs',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(10),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFF7CE45),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // السعر
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${professional.pricePerHour.toInt()}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 2.height),
                      Text(
                        '/hour',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSurface.withValues(alpha: .62),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              top: buttonTop,
              right: buttonRight,
              child: GestureDetector(
                onTap: onFavoriteToggle ?? onTap,
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colorScheme.surface, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isFavoritesCard
                        ? Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            key: ValueKey(isFavorite),
                            color: const Color(0xFFEF4444),
                            size: 20.width,
                          )
                        : Builder(
                            builder: (context) {
                              final isRtl =
                                  Directionality.of(context) ==
                                  TextDirection.rtl;
                              return Transform.flip(
                                flipX: isRtl,
                                child: Icon(
                                  Icons.arrow_outward_rounded,
                                  color: const Color(0xFFF97316),
                                  size: 20.width,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
