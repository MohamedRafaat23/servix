import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

/// Shared field label used across profile sub-screens.
class ProfileFieldLabel extends StatelessWidget {
  final String label;
  const ProfileFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(13),
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }
}

/// Shared text field used across profile sub-screens.
class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: context.responsiveFontScale(13),
          color: const Color(0xFFB0BEC5),
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.greyColor, size: 20),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDE7F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF368CE1), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
        ),
      ),
    );
  }
}

/// Section label used on the profile screen.
class ProfileSectionLabel extends StatelessWidget {
  final String label;
  const ProfileSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            color: AppColors.greyColor,
          ),
        ),
      ),
    );
  }
}

/// Menu item row used in the profile screen.
class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final Color iconColor;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    this.icon,
    this.image,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.titleColor,
  }) : assert(icon != null || image != null, 'Either icon or image must be provided.');

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = icon != null
        ? Icon(icon, color: iconColor, size: 18.width)
        : Image.asset(image!, width: 18.width, height: 18.width, color: iconColor);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
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
            Container(
              width: 34.width,
              height: 34.width,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: iconWidget),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? const Color(0xFF1E293B),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFB0BEC5), size: 20),
          ],
        ),
      ),
    );
  }
}

/// Toggle row used in the profile settings section.
class ProfileMenuToggle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool value;
  final void Function(bool) onChanged;

  const ProfileMenuToggle({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 34.width,
            height: 34.width,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18.width),
          ),
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
