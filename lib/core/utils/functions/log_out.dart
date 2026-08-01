import 'package:servix/main.dart' as SrevixApp;

import '../constants/storage_keys.dart';
import 'common_fun.dart';
import '../../../config/router/app_routes_names.dart';
import '../../network/end_points.dart';
import '../../network/api_consumer.dart';
import '../constants/app_enums.dart';
import 'callback_token.dart';
import 'preference_utils.dart';
import 'router_handler.dart';
import '../../di/service_locator.dart';

Future<void> logOut({String? msg, bool isUseLogoutApi = false}) async {
  if (msg != null) {
    showToast(msg, state: ToastStates.error);
  }

  final storage = sl.get<HandleMulticallLocal>();
  final token = await storage.getLocalData(keyType: LocalEnumKey.accessToken);

  if (isUseLogoutApi && token != null && token.isNotEmpty) {
    try {
      final refreshToken = await storage.getLocalData(
        keyType: LocalEnumKey.refreshToken,
      );
      await sl.get<ApiConsumer>().post(
        EndPoints.logout,
        body: {'refresh_token': refreshToken ?? ''},
      );
    } catch (_) {
      // Continue clearing local session even if logout API fails.
    }
  }

  await storage.clearAuthSession();

  final prefs = sl.get<PreferenceUtils>();
  await prefs.remove(key: StorageKeys.isGuest);
  await prefs.remove(key: StorageKeys.userName);
  await prefs.remove(key: StorageKeys.userPicture);
  await prefs.remove(key: StorageKeys.userEmail);
  await prefs.remove(key: StorageKeys.userPhone);
  await prefs.remove(key: StorageKeys.postFcmKey);

  final context = SrevixApp.navigatorKey.currentContext;
  if (context != null && context.mounted) {
    await RouterHandler.navigate(
      context,
      AppRoutesNames.login,
      routerType: RouterType.goAndPopAll,
    );
  }
}
