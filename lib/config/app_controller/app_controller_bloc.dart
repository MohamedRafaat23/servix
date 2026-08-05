import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/functions/callback_token.dart';

import '../../core/network/end_points.dart';
import '../../core/network/api_consumer.dart';
import '../../core/utils/constants/app_enums.dart';
import '../../core/utils/constants/storage_keys.dart';
import '../../core/utils/functions/preference_utils.dart';
import '../../core/utils/functions/print_state.dart';
import '../../core/di/service_locator.dart';

part 'app_controller_event.dart';
part 'app_controller_state.dart';
   
class AppControllerBloc extends Bloc<AppControllerEvent, AppControllerState> {
  final PreferenceUtils prefs;
  final HandleMulticallLocal local;
  final ApiConsumer api;

  AppControllerBloc({required this.prefs, required this.local, required this.api})
    : super(
        AppControllerState(
         isGuest: prefs.getBool(StorageKeys.isGuest),
         isDarkMode: prefs.getBool(StorageKeys.isDarkMode),
        ),
      ) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
    on<GetNotificationCountEvent>(_getCountOfUnReadNot);
    on<RefreshGuestStatusEvent>(_onRefreshGuestStatus);
    on<ResetNotificationCountEvent>(_onResetNotificationCount);
  }

  void _onRefreshGuestStatus(
    RefreshGuestStatusEvent event,
    Emitter<AppControllerState> emit,
  ) {
    final bool isGuest = sl.get<PreferenceUtils>().getBool(StorageKeys.isGuest);
    emit(state.copyWith(isGuest: isGuest));

    if (!isGuest) {
      canCallNotificationsApi = true;
    }
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<AppControllerState> emit,
  ) async {
    final isDarkMode = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: isDarkMode));
    await prefs.setBool(StorageKeys.isDarkMode, isDarkMode);
  }

  Future<void> _onSetTheme(SetThemeEvent event, Emitter<AppControllerState> emit) async {
    emit(state.copyWith(isDarkMode: event.isDarkMode));
    await prefs.setBool(StorageKeys.isDarkMode, event.isDarkMode);
  }

  bool canCallNotificationsApi = true;
  Timer? timer;
  void setTimer() {
    canCallNotificationsApi = false;
    timer?.cancel();
    timer = Timer(const Duration(seconds: 120), () {
      canCallNotificationsApi = true;
    });
  }

 void _getCountOfUnReadNot(GetNotificationCountEvent event, Emitter<AppControllerState> emit) async {
    String? token = await sl.get<HandleMulticallLocal>().getLocalData(
      keyType: LocalEnumKey.accessToken,
    );

    if (state.isGuest || !canCallNotificationsApi || token == null) return;
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.notificationsCount,
      );
      response.fold(
        (failed) {
          printState(failed);
        },
        (success) {
          if (!isClosed) {
            setTimer();
            final res = success.response;
            final data = res['data'] is Map ? res['data'] : null;

            final int count =
                res['unread_count'] as int? ??
                res['notifications_count'] as int? ??
                res['count'] as int? ??
                (data != null
                    ? (data['unread_count'] as int? ??
                          data['notifications_count'] as int? ??
                          data['count'] as int? ??
                          0)
                    : 0);
            printState(count);
            emit(state.copyWith(notificationsCount: count));
          }
        },
      );
    } catch (e) {
      printState("Notifications count error: $e");
    }
  }

  void _onResetNotificationCount(ResetNotificationCountEvent event,  Emitter<AppControllerState> emit) {
    printState(state.notificationsCount);
    int newCount = state.notificationsCount;
    if (event.isReset) {
      emit(state.copyWith(notificationsCount: 0));
    } else if (newCount > 0) {
      emit(state.copyWith(notificationsCount: --newCount));
    }
  }
}
