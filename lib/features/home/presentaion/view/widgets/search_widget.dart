import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final VoidCallback? onIconPressed;
  final ValueChanged<String>? onChanged;

  const SearchWidget({
    super.key,
    required this.hintText,
    required this.icon,
    this.onIconPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.height,
      padding: EdgeInsets.symmetric(horizontal: 12.width),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 22.width,
          ),
          SizedBox(width: 10.width),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(
                  fontSize: 14.width,
                  color: AppColors.greyColor,
                ),
              ),
            ),
          ),
          if (onIconPressed != null)
            GestureDetector(
              onTap: onIconPressed,
              child: Container(
                width: 34.width,
                height: 34.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
