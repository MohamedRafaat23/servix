import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfileSaveButton extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onTap;
  final String label;

  const ProfileSaveButton({
    super.key,
    required this.isSubmitting,
    required this.onTap,
    this.label = 'Save',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
          vertical: 16.height,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52.height,
          child: ElevatedButton(
            onPressed: isSubmitting ? null : onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.radius)),
            ),
            child: isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}