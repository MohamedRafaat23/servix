import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../utils/functions/validate.dart';

class PhoneFieldPart extends StatelessWidget {
  const PhoneFieldPart({
    super.key,
    required this.onTypePhone,
    required this.controller,
    this.isEnabled = true,
    this.initialCountryCode = 'EG',
    this.title,
    this.error,
  });

  final TextEditingController controller;
  final Function(String fullNumber, String countryCode) onTypePhone;
  final bool isEnabled;
  final String initialCountryCode;
  final String? title;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final labelText = title ?? AppStrings.phoneNumber;
    // final isArabic = context.locale.languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The phone input field (must be LTR for phone numbers)
          Directionality(
            textDirection: ui.TextDirection.ltr,
            child: IntlPhoneField(
              keyboardType: TextInputType.number,
              cursorColor: AppColors.primaryColor,
              textAlign: TextAlign.start,
              controller: controller,
              showCountryFlag: true,
              initialValue: "+20",
              languageCode: "en",
              decoration: InputDecoration(
                hintText: "xxx xxxx xxx",
                hintTextDirection: ui.TextDirection.ltr,
                contentPadding: EdgeInsets.only(
                  left: 8.width,
                  right: 16.width,
                  top: 22.height,
                  bottom: 14.height,
                ),
                hintStyle: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.radius),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.radius),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.radius),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                ),

                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.radius),
                  borderSide: BorderSide(color: AppColors.errorColor, width: 1),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.radius),
                  borderSide: BorderSide(
                    color: AppColors.errorColor,
                    width: 1.5,
                  ),
                ),
                errorText: error,
                errorStyle: TextStyle(
                  fontSize: context.responsiveFontScale(12),
                  color: AppColors.errorColor,
                ),
                counterText: "",
              ),
              enabled: isEnabled,
              validator: (val) =>
                  (Validate.validatePhoneNumber(val?.completeNumber) ?? "")
                      .trim(),
              initialCountryCode: initialCountryCode,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  if (newValue.text.length == 11 &&
                      newValue.text.startsWith('0')) {
                    final newText = newValue.text.substring(1);
                    return TextEditingValue(
                      text: newText,
                      selection: TextSelection.collapsed(
                        offset: newValue.selection.baseOffset > 0
                            ? newValue.selection.baseOffset - 1
                            : newText.length,
                      ),
                    );
                  }
                  return newValue;
                }),
              ],
              onChanged: (phone) {
                String number = phone.number;
                if (number.startsWith('0')) {
                  number = number.substring(1);
                }
                onTypePhone("${phone.countryCode}$number", phone.countryCode);
              },
            ),
          ),

          // RTL floating label overlaid on the top-right border area
          Positioned(
            top: -10,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: AppColors.whiteColor,

              child: Text(
                labelText,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
