import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/app_enums.dart';

/// Converts Arabic/Indic numerals (٠-٩) to Western (0-9) for API payloads.
/// Use when sending date/time or numbers so the backend always receives ASCII digits.
String toWesternNumerals(String? input) {
  if (input == null || input.isEmpty) return input ?? '';
  const arabicNumerals = '٠١٢٣٤٥٦٧٨٩';
  const westernNumerals = '0123456789';
  String result = input;
  for (int i = 0; i < arabicNumerals.length; i++) {
    result = result.replaceAll(arabicNumerals[i], westernNumerals[i]);
  }
  return result;
}

/// Recursively converts all string values in a map/list to Western numerals.
/// Use before sending order/request body so the API always receives ASCII digits (e.g. when lang is AR).
Map<String, dynamic> toWesternNumeralsMap(Map<String, dynamic> map) {
  final result = <String, dynamic>{};
  for (final e in map.entries) {
    final value = e.value;
    if (value is Map) {
      result[e.key] = toWesternNumeralsMap(Map<String, dynamic>.from(value));
    } else if (value is List) {
      result[e.key] = value.map((item) {
        if (item is Map) return toWesternNumeralsMap(Map<String, dynamic>.from(item));
        if (item is String) return toWesternNumerals(item);
        return item;
      }).toList();
    } else if (value is String) {
      result[e.key] = toWesternNumerals(value);
    } else {
      result[e.key] = value;
    }
  }
  return result;
}

String formatDateTime(String? dateStr, String? timeStr, {bool isArabic = false}) {
  if (dateStr == null || dateStr.isEmpty) return 'N/A';
  try {
    final date = DateTime.parse(dateStr);
    final String locale = isArabic ? 'ar' : 'en';
    String formattedDate = DateFormat('d MMM', locale).format(date);

    if (timeStr != null && timeStr.isNotEmpty) {
      final timeParts = timeStr.split(':');
      if (timeParts.length >= 2) {
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);
        final time = DateTime(date.year, date.month, date.day, hour, minute);
        String formattedTime = DateFormat('h:mm a', locale).format(time);
        return isArabic ? '$formattedDate، $formattedTime' : '$formattedDate, $formattedTime';
      }
    }
    return formattedDate;
  } catch (e) {
    return '$dateStr ${timeStr ?? ''}'.trim();
  }
}

String formatAppointmentTime(String? dateStr, String? fromTimeStr, String? toTimeStr, {bool isArabic = false}) {
  if (dateStr == null || dateStr.isEmpty) return 'N/A';
  try {
    final date = DateTime.parse(dateStr);
    String locale = isArabic ? 'ar' : 'en';
    String dayName = DateFormat('EEEE', locale).format(date);

    String fromTime = _formatSingleTime(fromTimeStr, isArabic: isArabic) ?? 'N/A';
    String toTime = _formatSingleTime(toTimeStr, isArabic: isArabic) ?? 'N/A';

    if (isArabic) {
      return '$dayName - من $fromTime إلى $toTime';
    }
    return '$dayName - From $fromTime To $toTime';
  } catch (e) {
    return dateStr;
  }
}

String formatTimeTo12Hour(String? timeStr, {bool isArabic = false}) {
  if (timeStr == null || timeStr.isEmpty) return '';

  final timeParts = timeStr.split(':');
  if (timeParts.length >= 2) {
    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    if (hour == null || minute == null) return timeStr;

    final time = DateTime(2024, 1, 1, hour, minute);
    final locale = isArabic ? 'ar' : 'en';
    return DateFormat('h:mm a', locale).format(time);
  }

  return timeStr;
}

String formatTimeRangeLabel(String range, {bool isArabic = false}) {
  const separator = ' - ';
  final index = range.indexOf(separator);
  if (index == -1) {
    return formatTimeTo12Hour(range, isArabic: isArabic);
  }

  final start = range.substring(0, index);
  final end = range.substring(index + separator.length);
  return '${formatTimeTo12Hour(start.trim(), isArabic: isArabic)} - ${formatTimeTo12Hour(end.trim(), isArabic: isArabic)}';
}

String? _formatSingleTime(String? timeStr, {bool isArabic = false}) {
  if (timeStr == null || timeStr.isEmpty) return null;
  return formatTimeTo12Hour(timeStr, isArabic: isArabic);
}

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

void showToast(String msg, {
  ToastStates? state,
  Color? textColor,
  Color? backgroundColor,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? chooseToastColor(state ?? ToastStates.info),
    textColor: textColor ?? AppColors.whiteColor,
  );
}

void appToast(String msg, {ToastStates state = ToastStates.success}) {
  showToast(msg, state: state);
}

Color chooseToastColor(ToastStates state) {
  Color color = AppColors.greyColor.withValues(alpha: 0.2);
  switch (state) {
    case ToastStates.success:
      color = AppColors.successColor;
      break;
    case ToastStates.warning:
      color = AppColors.warningColor;
      break;
    case ToastStates.error:
      color = AppColors.errorColor;
      break;
    case ToastStates.info:
      color = AppColors.infoColor;
      break;
  }
  return color;
}

String idToStatus(int id) {
  switch (id) {
    case 2:
      return 'PENDING';
    case 3:
      return 'CONFIRMED';
    case 4:
      return 'IN_PROGRESS';
    case 5:
      return 'COMPLETED';
    case 6:
      return 'CANCELLED';
    case 7:
      return 'REJECTED';
    default:
      return 'all';
  }
}