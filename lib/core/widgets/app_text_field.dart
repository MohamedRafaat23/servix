import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/app_colors.dart';
import '../utils/functions/responsive.dart';

class AppTextField extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final String? hint;
  final double? hintFontSize;
  final int? maxlines;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? title;
  final void Function()? onTapSuffixIcon;
  final void Function()? onTapField;
  final IconData? suffixIcon;
  final String? suffixImage;
  final List<TextInputFormatter> inputFormatters;
  final IconData? prefexIcon;
  final Widget? prefexIconWidget;
  final Widget? suffixIconWidget;
  final Color? prefexIconColor;
  final Color? suffixIconColor;
  final Color? borderColor;
  final List<Color>? gradientBorderColors;
  final bool isReadOnly;
  final bool isWithTitle;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? hintColor;
  final double borderWidth;
  final TextStyle? hintStyle;
  final double? bottomPadding;
  final bool isUnderLineBorder;
  final bool isDense;
  final bool hasBorder;
  final bool filled;
  final Color? fillColor;

  const AppTextField({
    super.key,
    this.validator,
    this.bottomPadding,
    this.isUnderLineBorder = false,
    this.isDense = false,
    this.hasBorder = true,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.emailAddress,
    this.obscureText = false,
    this.title,
    this.prefexIconColor,
    this.onTapSuffixIcon,
    this.hint,
    this.hintFontSize,
    this.onTapField,
    this.suffixIcon,
    this.suffixImage,
    this.focusNode,
    this.onEditingComplete,
    this.onChanged,
    this.inputFormatters = const [],
    this.controller,
    this.textAlign = TextAlign.start,
    this.maxlines = 1,
    this.prefexIcon,
    this.prefexIconWidget,
    this.suffixIconWidget,
    this.isWithTitle = true,
    this.isReadOnly = false,
    this.borderColor,
    this.gradientBorderColors,
    this.borderRadius,
    this.contentPadding,
    this.hintColor,
    this.borderWidth = 1.0,
    this.hintStyle,
    this.suffixIconColor,
    this.filled = false,
    this.fillColor,
  });

  InputBorder borderShape({Color? color, bool isFocused = false}) {
    // When filled mode: use transparent borders so only the fill shows
    if (filled) {
      if (!isFocused) {
        return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
        borderSide: BorderSide.none,
        
      );
      }
      // Show a subtle primary bottom-line on focus
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      );
    }
    if (!hasBorder) return InputBorder.none;
    return isUnderLineBorder
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: color ?? AppColors.primaryColor, width: 1.3),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            borderSide: BorderSide(
              color: color ?? borderColor ?? const Color(0xffC7C7C7),
              width: borderWidth,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: (isWithTitle && title != null) ? 10 : 0,
            bottom: isWithTitle ? (context.isTablet ? 14.height : 6.height) : 0,
          ),
          child: TextFormField(
              onTap: onTapField,
              cursorColor: AppColors.primaryColor,
              inputFormatters: inputFormatters,
              textInputAction: textInputAction,
              maxLines: maxlines,
              textAlign: filled ? TextAlign.end : textAlign,
              keyboardType: textInputType,
              focusNode: focusNode,
              controller: controller,
              readOnly: isReadOnly,
              validator: validator,
              onEditingComplete: onEditingComplete,
              onChanged: onChanged,
              obscureText: obscureText,
              decoration: InputDecoration(
                filled: filled,
                fillColor: fillColor ?? (filled ? const Color(0xFFF5F5F5) : null),
                isDense: isDense || !isWithTitle,
                contentPadding: contentPadding ??
                    EdgeInsets.only(
                      left: 16.width,
                      right: 16.width,
                      // Extra top padding to make room for floating label on the border
                      top: (isWithTitle && title != null) ? 20.height : 14.height,
                      bottom: 14.height,
                    ),
                // Floating label – sits on the top border line
                label: (isWithTitle && title != null)
                    ? Text(
                        title!,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      )
                    : null,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                hint: hint == null
                    ? null
                    : Text(
                        hint ?? "",
                        textAlign: TextAlign.start,
                        style: hintStyle ?? TextStyle(
                          fontSize:
                              hintFontSize ?? context.responsiveFontScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                border: borderShape(),
                enabledBorder: borderShape(),
                focusedBorder: borderShape(isFocused: true),
                errorBorder: borderShape(color: Colors.red),
                focusedErrorBorder: borderShape(color: Colors.red),
                alignLabelWithHint: true,
                suffixIcon: suffixIconWidget ??
                    (suffixIcon == null
                        ? suffixImage == null
                            ? null
                            : GestureDetector(
                                onTap: onTapSuffixIcon,
                                child: Image.asset(
                                  suffixImage!,
                                  width: 26,
                                  height: 26,
                                  color: suffixIconColor,
                                ),
                              )
                        : GestureDetector(
                            onTap: onTapSuffixIcon,
                            child: Icon(
                              suffixIcon,
                              color: suffixIconColor ?? AppColors.textColor,
                            ),
                          )),
                prefixIcon: prefexIconWidget != null
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(end: 10.width),
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: prefexIconWidget,
                        ),
                      )
                    : (prefexIcon == null
                        ? null
                        : Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 10.width,
                            ),
                            child: Icon(
                              prefexIcon,
                              size: 26.width,
                              color: prefexIconColor ?? AppColors.primaryColor,
                            ),
                          )),
              ),
            ),
          ),
        ],
      );
  }
}
