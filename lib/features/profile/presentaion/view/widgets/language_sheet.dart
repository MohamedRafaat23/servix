import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'confirm_dialog.dart'; // عدّل المسار حسب مكانه عندك

class LanguageOption {
  final String code; // 'en' / 'ar'
  final String label;

  const LanguageOption({required this.code, required this.label});
}

Future<String?> showLanguageSheet(BuildContext context) async {
  final currentCode = context.locale.languageCode;

  final languages = [
    LanguageOption(code: 'ar', label: AppStrings.arabicLanguage),
    LanguageOption(code: 'en', label: AppStrings.englishLanguage),
  ];

  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sheetContext.responsiveHorizontalPadding,
            vertical: 20.height,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.language,
                style: TextStyle(
                  fontSize: sheetContext.responsiveFontScale(18),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: 16.height),
              ...languages.map((lang) {
                final isSelected = lang.code == currentCode;
                return InkWell(
                  onTap: () async {
                    if (isSelected) {
                      Navigator.pop(sheetContext);
                      return;
                    }
                    await showConfirmDialog(
                      sheetContext,
                      title: AppStrings.language,
                      content: '${AppStrings.changeLanguageTo} ${lang.label}?',
                      confirmLabel: AppStrings.change,
                      onConfirm: () {
                        Navigator.pop(sheetContext); // يقفل الـ ConfirmDialog
                        Navigator.pop(sheetContext, lang.code); // يقفل الـ Sheet ويرجّع الكود
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.height, horizontal: 4.width),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            lang.label,
                            style: TextStyle(
                              fontSize: sheetContext.responsiveFontScale(15),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: AppColors.lightPrimaryColor, size: 20.width),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}