import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/translation.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (prev, curr) => prev.selectedLanguage != curr.selectedLanguage,
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Title Row ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 28),
                    Text(
                      AppStrings.language,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ── Arabic Option ──
                _LangOption(
                  label: AppStrings.arabicLanguage,
                  langCode: 'ar',
                  selected: state.selectedLanguage == 'ar',
                  onTap: () => context.read<ProfileBloc>().add(
                    const SelectLanguageEvent('ar'),
                  ),
                ),

                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF1F5F9),
                ),

                // ── English Option ──
                _LangOption(
                  label: AppStrings.englishLanguage,
                  langCode: 'en',
                  selected: state.selectedLanguage == 'en',
                  onTap: () => context.read<ProfileBloc>().add(
                    SelectLanguageEvent('en'),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Save Button ──
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      final lang = state.selectedLanguage;
                      Navigator.pop(context);
                      context.read<ProfileBloc>().add(
                        LanguageProfileEvent(lang),
                      );
                      await changeLanguage(context, lang);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      AppStrings.save,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Single language row ──────────────────────────────────────────────────────
class _LangOption extends StatelessWidget {
  final String label;
  final String langCode;
  final bool selected;
  final VoidCallback onTap;

  const _LangOption({
    required this.label,
    required this.langCode,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: selected
                    ? AppColors.lightPrimaryColor
                    : const Color(0xFF475569),
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            Radio<String>(
              value: langCode,
              groupValue: selected ? langCode : '',
              onChanged: (_) => onTap(),
              activeColor: AppColors.lightPrimaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper لفتح الدايلوج مباشرة
Future<void> showLanguageDialog(BuildContext context) {
  // نبعت اللغة الحالية للـ BLoC قبل ما الدايلوج يتفتح
  final currentLang = EasyLocalization.of(context)?.locale.languageCode ?? 'ar';
  context.read<ProfileBloc>().add(SelectLanguageEvent(currentLang));

  return showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<ProfileBloc>(),
      child: const LanguageDialog(),
    ),
  );
}
