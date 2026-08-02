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
import 'package:servix/features/auth/domain/usecases/check_auth_status_usecase.dart';

import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:servix/features/favorite/presentaion/bloc/favorite_event.dart';
import 'package:servix/features/home/data/repositories/facke_home_repository.dart';
import 'package:servix/features/home/domain/repositories/home_repository.dart';
import 'package:servix/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:servix/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:servix/features/home/domain/usecases/get_nearby_professionals_usecase.dart';
import 'package:servix/features/home/presentaion/bloc/home_bloc.dart';
import 'package:servix/features/navbar/presentation/bloc/navbar_bloc.dart';
import 'package:servix/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:servix/features/favorite/data/repositories/fake_favorite_repository.dart';
import 'package:servix/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:servix/features/favorite/domain/usecases/get_favorites_usecase.dart';
import 'package:servix/features/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'package:servix/features/favorite/presentaion/bloc/favorite_bloc.dart';
import 'package:servix/features/profile/data/repositories/fake_profile_repository.dart';
import 'package:servix/features/profile/domain/repositories/profile_repository.dart';
import 'package:servix/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:servix/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:servix/features/profile/domain/usecases/manage_addresses_usecase.dart';
import 'package:servix/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/order/data/repositories/fake_order_repository.dart';
import 'package:servix/features/order/domain/repositories/order_repository.dart';
import 'package:servix/features/order/domain/usecases/get_order_details_usecase.dart';
import 'package:servix/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:servix/features/order/domain/usecases/reorder_usecase.dart';
import 'package:servix/features/order/presentaion/bloc/order_bloc.dart';
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
  //"كل واحد يطلب AuthRepository، اديله AuthRepositoryImpl." من غير ما يعرف ال usecase
  sl.registerLazySingleton<AuthRepository>(
    () => useFakeApi
        ? FakeAuthRepository()
        : AuthRepositoryImpl(sl<ApiConsumer>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () =>
        FakeHomeRepository(), // لو عايز حقيقي بعدين: useFakeApi ? FakeHomeRepository() : HomeRepositoryImpl(...)
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

  sl.registerLazySingleton<GetBannersUseCase>(
    () => GetBannersUseCase(sl<HomeRepository>()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<GetNearbyProfessionalsUseCase>(
    () => GetNearbyProfessionalsUseCase(sl<HomeRepository>()),
  );

  // Blocs

  sl.registerLazySingleton<AppControllerBloc>(
    () => AppControllerBloc(
      prefs: sl<PreferenceUtils>(),
      local: sl<HandleMulticallLocal>(),
      api: sl<ApiConsumer>(),
    ),
  );

  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<SplashBloc>(
    () => SplashBloc(
      sl<CheckAuthStatusUseCase>(),
      sl<PreferenceUtils>(),
    ),
  );
  sl.registerFactory<NavbarBloc>(() => NavbarBloc());

  sl.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(sl<PreferenceUtils>()),
  );
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<LoginUseCase>()));

  sl.registerFactory<ForgetPasswordBloc>(
    () => ForgetPasswordBloc(
      sl<ForgetPasswordUseCase>(),
      sl<ResetPasswordUseCase>(),
    ),
  );

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl<RegisterUsecase>()));

  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl<GetCategoriesUseCase>(),
      sl<GetNearbyProfessionalsUseCase>(),
      sl<GetBannersUseCase>(),
    ),
  );

  // Favorite Feature
  sl.registerLazySingleton<FavoriteRepository>(
    () => FakeFavoriteRepository(),
  );

  sl.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(sl<FavoriteRepository>()),
  );

  sl.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(sl<FavoriteRepository>()),
  );

  sl.registerLazySingleton<FavoriteBloc>(
  () => FavoriteBloc(
    getFavoritesUseCase: sl<GetFavoritesUseCase>(),
    toggleFavoriteUseCase: sl<ToggleFavoriteUseCase>(),
  )..add(const FavoritesFetchRequested()), 
);

  // Profile Feature
  sl.registerLazySingleton<ProfileRepository>(
    () => FakeProfileRepository(),
  );

  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<GetSavedAddressesUseCase>(
    () => GetSavedAddressesUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<AddSavedAddressUseCase>(
    () => AddSavedAddressUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<DeleteSavedAddressUseCase>(
    () => DeleteSavedAddressUseCase(sl<ProfileRepository>()),
  );

  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: sl<GetProfileUseCase>(),
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
      addSavedAddressUseCase: sl<AddSavedAddressUseCase>(),
      deleteSavedAddressUseCase: sl<DeleteSavedAddressUseCase>(),
    ),
  );

  // Order Feature
  sl.registerLazySingleton<OrderRepository>(
    () => FakeOrderRepository(),
  );

  sl.registerLazySingleton<GetOrdersUseCase>(
    () => GetOrdersUseCase(sl<OrderRepository>()),
  );

  sl.registerLazySingleton<GetOrderDetailsUseCase>(
    () => GetOrderDetailsUseCase(sl<OrderRepository>()),
  );

  sl.registerLazySingleton<ReorderUseCase>(
    () => ReorderUseCase(sl<OrderRepository>()),
  );

  sl.registerFactory<OrderBloc>(
    () => OrderBloc(
      getOrdersUseCase: sl<GetOrdersUseCase>(),
      getOrderDetailsUseCase: sl<GetOrderDetailsUseCase>(),
      reorderUseCase: sl<ReorderUseCase>(),
    ),
  );
}
