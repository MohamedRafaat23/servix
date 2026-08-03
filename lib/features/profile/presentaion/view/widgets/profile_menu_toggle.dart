import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfileMenuToggle extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final Color? iconColor;
  final String title;
  final bool value;
  final void Function(bool) onChanged;

  const ProfileMenuToggle({
    super.key,
    this.icon,
    this.image,
     this.iconColor,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : assert(icon != null || image != null, 'Either icon or image must be provided.');

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = icon != null
        ? Icon(icon, color: iconColor, size: 22.width)
        : Image.asset(image!, width: 22.width, height: 22.width, color: iconColor);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 10.height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          iconWidget,
          SizedBox(width: 12.width),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.lightPrimaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}