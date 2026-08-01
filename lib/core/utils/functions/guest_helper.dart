import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_controller/app_controller_bloc.dart';
import '../../../config/router/app_routes_names.dart';
import '../../widgets/login_required_widget.dart';
import '../constants/app_enums.dart';
import '../constants/storage_keys.dart';
import 'preference_utils.dart';
import 'router_handler.dart';
import '../../di/service_locator.dart';

class GuestHelper {
  GuestHelper._();

  static bool isGuestMode() {
    return sl.get<PreferenceUtils>().getBool(StorageKeys.isGuest);
  }

  static bool isGuest(BuildContext context) {
    return context.read<AppControllerBloc>().state.isGuest;
  }

  static Future<void> continueAsGuest(BuildContext context) async {
    await sl.get<PreferenceUtils>().setBool(StorageKeys.isGuest, true);
    if (!context.mounted) return;

    context.read<AppControllerBloc>().add(const RefreshGuestStatusEvent());
    await RouterHandler.navigate(
      context,
      AppRoutesNames.navbar,
      routerType: RouterType.goAndPopAll,
    );
  }

  static void requireLogin(BuildContext context, VoidCallback onAuthenticated) {
    if (isGuest(context)) {
      LoginRequiredWidget.show(context);
      return;
    }
    onAuthenticated();
  }
}
