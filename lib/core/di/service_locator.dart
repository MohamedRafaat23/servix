import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:servix/config/app_controller/app_controller_bloc.dart';

import 'package:servix/core/network/api_consumer.dart';
import 'package:servix/core/network/dio_consumer.dart';
import 'package:servix/core/network/network_info.dart';
import 'package:servix/core/network/implementation/network_info_impl.dart';

import 'package:servix/core/repository/maps/geocoding_service.dart';
import 'package:servix/core/repository/maps/google_map_service.dart';
import 'package:servix/core/repository/maps/map_service.dart';

import 'package:servix/core/utils/functions/callback_token.dart';
import 'package:servix/core/utils/functions/preference_utils.dart';

import 'package:servix/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:servix/features/auth/domain/repositories/auth_repository.dart';
import 'package:servix/features/auth/domain/repositories/facke_auth_rebo.dart';
import 'package:servix/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:servix/features/auth/domain/usecases/login_usecase.dart';
import 'package:servix/features/auth/domain/usecases/register_usecase.dart';
import 'package:servix/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:servix/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:servix/features/auth/domain/usecases/verify_otp_usecase.dart';

import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:servix/features/navbar/presentation/bloc/navbar_bloc.dart';
import 'package:servix/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:servix/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:servix/features/splash/presentation/splash_bloc/splash_bloc.dart';

final sl = GetIt.instance;

/// 🔧 خليها false لما الـ API الحقيقي يجهز
const bool useFakeApi = true;

Future<void> initServiceLocator() async {
  // يمسح أي تسجيل قديم قبل ما نسجل من جديد
  // (بيحمينا من "already registered" لو الدالة دي اتنادت أكتر من مرة،
  // زي وقت Hot Restart أو أي استدعاء مكرر في التطبيق)
  await sl.reset();

  // Local Storage
  await PreferenceUtils.init();

  sl.registerLazySingleton<PreferenceUtils>(() => PreferenceUtils());
  sl.registerLazySingleton<HandleMulticallLocal>(() => HandleMulticallLocal());

  // Core
  // ==========================
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(sl<Dio>()));

  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // Map Services
  sl.registerLazySingleton<MapService>(() => GoogleMapService());

  sl.registerLazySingleton<GeocodingService>(() => GeocodingService());

  // Repository
  // Fake implementation used during UI-only development, before the real
  // API is ready. Set useFakeApi = false above once the backend is ready —
  // no other code (UseCases, Blocs, Screens) needs to change.
  sl.registerLazySingleton<AuthRepository>(
    () => useFakeApi
        ? FakeAuthRepository()
        : AuthRepositoryImpl(sl<ApiConsumer>()),
  );

  // UseCases
  sl.registerLazySingleton<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(sl<AuthRepository>()),
  );

  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<LoginUseCase>()));

  // Blocs

  sl.registerLazySingleton<AppControllerBloc>(
    () => AppControllerBloc(
      prefs: sl<PreferenceUtils>(),
      local: sl<HandleMulticallLocal>(),
      api: sl<ApiConsumer>(),
    ),
  );

  sl.registerFactory<ForgetPasswordBloc>(
    () => ForgetPasswordBloc(
      sl<ForgetPasswordUseCase>(),
      sl<ResetPasswordUseCase>(),
    ),
  );

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl<RegisterUsecase>()));

  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(sl<AuthRepository>()),
  );

  sl.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(sl<PreferenceUtils>()),
  );
  sl.registerFactory<SplashBloc>(
    () => SplashBloc(sl<CheckAuthStatusUseCase>()),
  );
   sl.registerFactory<NavbarBloc>(() => NavbarBloc());

}