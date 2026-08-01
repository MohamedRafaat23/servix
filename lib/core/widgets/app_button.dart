import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/functions/responsive.dart';
import 'loading_item.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Color? textColor, borderColor;
  final VoidCallback? onTap;
  final double? radius, textSize;
  final Color? colorBG;
  final Widget? child;
  final bool isLoading;
  final bool isOutline;
  final EdgeInsetsGeometry? btnPadding;
  final double? width;
  final double? height;
  final double borderWidth;
   final FontWeight? fontWeight;
   final BorderRadiusGeometry? customBorderRadius;
 
  const AppButton({
    super.key,
    this.child,
    this.borderColor,
    this.radius = 40,
    this.customBorderRadius,
    this.textSize,
    required this.onTap,
    this.text,
    this.btnPadding,
    this.colorBG,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.isOutline = false,
    this.borderWidth = .6,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        color: colorBG,
         border: isOutline
            ? Border.all(
                color: borderColor ?? AppColors.primaryColor,
                width: borderWidth,
              )
            : null,
         borderRadius: customBorderRadius ?? BorderRadius.circular(radius ?? 10),
         gradient: colorBG == null
            ? LinearGradient(
                colors: AppColors.gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: btnPadding ?? EdgeInsets.zero,
          backgroundColor: isOutline ? Colors.white : AppColors.transparent,
          shadowColor: AppColors.transparent,
          maximumSize: Size(width ?? double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: customBorderRadius ?? BorderRadius.circular(radius ?? 10),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? Center(
                child: Padding(
                  padding:const EdgeInsets.symmetric(vertical: 7),
                  child: SizedBox(
                    child: LoadingItem(
                      color: isOutline
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ),
              )
            : child ??
                  SizedBox(
                    width: width,
                    child: Center(
                      child: Text(
                        text ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              textColor ??
                              (isOutline
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor),
                          fontWeight: fontWeight ?? FontWeight.w600,
                          fontSize: context.responsiveFontScale(textSize ?? 16),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
