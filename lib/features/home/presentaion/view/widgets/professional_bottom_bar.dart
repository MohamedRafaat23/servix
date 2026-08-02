import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfessionalBottomBar extends StatelessWidget {
  final double? pricePerHour;
  final VoidCallback? onCallTap;
  final VoidCallback? onBookTap;

  const ProfessionalBottomBar({
    super.key,
    this.pricePerHour,
    this.onCallTap,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEBF3FA),
      padding: EdgeInsets.only(
        left: context.responsiveHorizontalPadding,
        right: context.responsiveHorizontalPadding,
        bottom: 16.height,
        top: 8.height,
      ),
      child: Row(
        children: [
          // Phone Call Button
          InkWell(
            onTap: onCallTap,
            borderRadius: BorderRadius.circular(27.radius),
            child: Container(
              width: 54.width,
              height: 54.width,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFEDD5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.phone_outlined,
                color: const Color(0xFFF97316),
                size: 22.width,
              ),
            ),
          ),
          SizedBox(width: 12.width),
          // Book Button
          Expanded(
            child: SizedBox(
              height: 54.height,
              child: ElevatedButton(
                onPressed: onBookTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.radius),
                  ),
                ),
                child: Text(
                  'Book · \$${pricePerHour?.toStringAsFixed(0) ?? '0'}/Hr',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
