import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelLabel;
  final String confirmLabel;
  final Color confirmColor;
  final Color? titleColor;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.cancelLabel = '',
    this.confirmLabel = '',
    this.confirmColor = AppColors.lightPrimaryColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelLabel),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(confirmLabel, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

/// Helper بيفتح الـ Dialog مباشرة من غير ما تكرر showDialog(...) في كل مكان
Future<void> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  required VoidCallback onConfirm,
  String? cancelLabel,
  String? confirmLabel,
  Color confirmColor = AppColors.lightPrimaryColor,
  Color? titleColor,
}) {
  return showDialog(
    context: context,
    builder: (_) => ConfirmDialog(
      title: title,
      content: content,
      cancelLabel: cancelLabel ?? AppStrings.cancel,
      confirmLabel: confirmLabel ?? AppStrings.save,
      confirmColor: confirmColor,
      titleColor: titleColor,
      onConfirm: onConfirm,
    ),
  );
}