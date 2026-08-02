import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';

/// يعرض SnackBar للنجاح/الفشل بناءً على أي state فيها successMessage/errorMessage.
/// يستخدم مع أي Bloc State طالما فيها الحقلين دول.
void showProfileFeedback(
  BuildContext context, {
  String? successMessage,
  String? errorMessage,
}) {
  if (successMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successMessage),
        backgroundColor: AppColors.lightPrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
  if (errorMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}