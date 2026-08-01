import 'package:flutter/material.dart';
import '../../config/router/app_routes_names.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_enums.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'app_button.dart';

class LoginRequiredWidget extends StatelessWidget {
  final bool isDialog;
  const LoginRequiredWidget({super.key, this.isDialog = false});

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: 660.width,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.width),
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 120.width,
                  height: 120.width,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 56.width,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20.height),
                Text(
                  AppStrings.loginRequiredTitle,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(22),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 12.height),
                Text(
                  AppStrings.loginRequiredSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.height, width: 20.width),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  AppButton(
                    text: AppStrings.login,
                    onTap: () {
                      if (isDialog) Navigator.pop(context);
                      RouterHandler.navigate(
                        context,
                        AppRoutesNames.login,
                        routerType: RouterType.goAndPopAll,
                      );
                    },
                  ),
                  SizedBox(height: 16.height),
                  AppButton(
                    text: AppStrings.signUp,
                    isOutline: true,
                    onTap: () {
                      if (isDialog) Navigator.pop(context);
                      RouterHandler.navigate(
                        context,
                        AppRoutesNames.register,
                        routerType: RouterType.goAndPopAll,
                      );
                    },
                  ),
                  SizedBox(height: 16.height),
                  TextButton(
                    onPressed: () {
                      if (isDialog) {
                        Navigator.pop(context);
                      } else {
                        // context.read<NavbarBloc>().add(
                        //   const ChangePageEvent(page: 0),
                        // );
                      }
                    },
                    child: Text(
                      AppStrings.maybeLater,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ],
              ),
     
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.radius),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: SingleChildScrollView(
            child: LoginRequiredWidget(isDialog: true),
          ),
        ),
      ),
    );
  }
}
