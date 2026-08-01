import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/app_controller/app_controller_bloc.dart';
import '../../config/router/app_routes_names.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'image_item.dart';
import 'login_required_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBackPressed,
    this.centerTitle = true,
    this.showNotificationsIcon = true,
    this.titleStyle,
    this.bottom,
    this.hideBackButton = false,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final bool showNotificationsIcon;
  final PreferredSizeWidget? bottom;
  final TextStyle? titleStyle;
  final bool hideBackButton;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;

    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: bottom,
      leading: (!hideBackButton && RouterHandler.canPop(context))
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.lightTextColor,
                size: (isTablet ? 27 : 18).width,
              ),
              onPressed: onBackPressed ?? () => RouterHandler.pop(context),
            )
          : null,
      centerTitle: centerTitle,
      title: Text(
        title,
        style:
            titleStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextColor,
              fontSize: (isTablet ? 28 : 18).fontSize,
            ),
      ),
      actions: [
        if (showNotificationsIcon)
          BlocBuilder<AppControllerBloc, AppControllerState>(
            builder: (context, state) {
              final bool isGuest = state.isGuest;
              return IconButton(
                onPressed: () {
                  if (isGuest) {
                    LoginRequiredWidget.show(context);
                  } else {
                    RouterHandler.navigate(
                      context,
                      AppRoutesNames.notifications,
                    );
                  }
                },
                icon: Badge.count(
                  count: isGuest ? 0 : state.notificationsCount,
                  backgroundColor: !isGuest && state.notificationsCount > 0
                      ? null
                      : Colors.transparent,
                  child: ImageItem(
                    AppImages.notification,
                    color: AppColors.primaryColor,
                    width: 24.width,
                    height: 24.width,
                  ),
                ),
              );
            },
          ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            end: (isTablet ? 20.0 : 16.0).width,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: actions ?? []),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    (bottom == null ? kToolbarHeight : kToolbarHeight + 60).height,
  );
}
