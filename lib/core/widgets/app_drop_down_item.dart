import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/functions/responsive.dart';

class AppDropDownItem extends StatelessWidget {
  const AppDropDownItem({
    super.key,
    this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = "",
    this.isEnabled = true,
  });
  final String? title;
  final String? value;
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w500,
              color: AppColors.lightTextColor,
            ),
          ),
        Container(
          height: 52,
          margin: EdgeInsets.only(
            top: 8,
            bottom: context.isTablet ? 10.height : 6.height,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.radius),
            border:
                Border.all(color: AppColors.borderGrayColor.withValues(alpha:0.5)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.width),
              borderRadius: BorderRadius.circular(25.radius),
              value: value,
              icon: Icon(Icons.arrow_drop_down,
                  color: AppColors.lightPrimaryColor, size: 24.radius),
              items: items
                  .map(
                      (item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: isEnabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }
}
