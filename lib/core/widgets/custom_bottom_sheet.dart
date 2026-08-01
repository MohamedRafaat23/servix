import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/functions/responsive.dart';

class AppBottomSheet {
  static double bottomActionPadding(BuildContext context) => 20.height;

  static EdgeInsets contentPadding(BuildContext context) {
    final isTablet =
        ResponsiveUtils.getDeviceType(context) == DeviceType.tablet;
    return EdgeInsets.fromLTRB(
      isTablet ? 40.0 : 24.0,
      isTablet ? 32.0 : 20.0,
      isTablet ? 40.0 : 24.0,
      bottomActionPadding(context),
    );
  }

  static Widget wrapSheetBody(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(top: false, child: child),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? titleWidget,
    Widget? content,
    List<Widget>? actions,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    Color? backgroundColor,
    bool useRootNavigator = false,
  }) {
    final isTablet =
        ResponsiveUtils.getDeviceType(context) == DeviceType.tablet;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final maxWidth = isTablet ? 600.0 : screenWidth;

    final maxPossibleHeight =
        height ?? screenHeight * (isTablet ? 0.75 : 0.85);

    Widget buildContent(BuildContext context) {
      return Container(
        width: maxWidth,
        constraints: BoxConstraints(
          maxHeight: maxPossibleHeight,
          minHeight: 120,
        ),
        padding: contentPadding(context),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.whiteColor,
          borderRadius: isTablet
              ? BorderRadius.circular(28.0)
              : const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child:
                  titleWidget ??
                  (title != null
                      ? Center(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.lightTextColor,
                                  fontSize: isTablet ? 22 : 18,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        )
                      : const SizedBox.shrink()),
            ),
            if (content != null)
              Flexible(child: SingleChildScrollView(child: content)),
            if (actions != null && actions.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: isTablet ? 32.0 : 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: actions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final action = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index > 0 ? (isTablet ? 16.0 : 12.0) : 0,
                      ),
                      child: action,
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      );
    }

    if (isTablet) {
      return showDialog<T>(
        context: context,
        barrierDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        builder: (context) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: maxPossibleHeight,
              ),
              child: Material(
                color: Colors.transparent,
                child: buildContent(context),
              ),
            ),
          );
        },
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (context) {
        return AppBottomSheet.wrapSheetBody(context, buildContent(context));
      },
      clipBehavior: Clip.none,
    );
  }
}
