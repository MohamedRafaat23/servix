import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/storage_keys.dart';
import 'package:servix/core/utils/functions/preference_utils.dart';
import '../../../auth/domain/usecases/check_auth_status_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final PreferenceUtils preferenceUtils;

  SplashBloc(this.checkAuthStatusUseCase, this.preferenceUtils)
      : super(const SplashState()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    final isLoggedIn = await checkAuthStatusUseCase();
    final hasSeenOnboarding = preferenceUtils.getBool(StorageKeys.onBoarding);

    emit(
      state.copyWith(
        status: isLoggedIn
            ? SplashStatus.authenticated
            : SplashStatus.unauthenticated,
        hasSeenOnboarding: hasSeenOnboarding,
      ),
    );
  }
}
