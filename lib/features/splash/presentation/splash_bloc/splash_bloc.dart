import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/usecases/check_auth_status_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  SplashBloc(this.checkAuthStatusUseCase) : super(const SplashState()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
  SplashStarted event,
  Emitter<SplashState> emit,
) async {
  print("Splash Event");

  final isLoggedIn = await checkAuthStatusUseCase();

  print("isLoggedIn = $isLoggedIn");

  emit(
    state.copyWith(
      status: isLoggedIn
          ? SplashStatus.authenticated
          : SplashStatus.unauthenticated,
    ),
  );
}

  
  }
