import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.width),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 56.width,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 20.height),
            Text(
              AppStrings.noFavorites,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              AppStrings.tapTheHeartIconOnAnyProfessionalOrServiceToAddThemTOYourFav,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
