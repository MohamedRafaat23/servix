import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfileAvatarEditable extends StatelessWidget {
  final VoidCallback? onEditTap;

  const ProfileAvatarEditable({super.key, this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightPrimaryColor.withValues(alpha: .15),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 48.width,
            backgroundColor: const Color(0xFFDDE7F0),
            child: Image.asset(AppImages.profile),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              width: 28.width,
              height: 28.width,
              decoration: const BoxDecoration(
                color: Color(0xFFF97316),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.edit, color: Colors.white, size: 14.width),
            ),
          ),
        ),
      ],
    );
  }
}