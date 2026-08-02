import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/features/auth/presentation/view/forget_password_screen.dart';
import 'package:servix/features/auth/presentation/view/login_screen.dart';
import 'package:servix/features/auth/presentation/view/otp_screen.dart';
import 'package:servix/features/auth/presentation/view/register_screen.dart';
import 'package:servix/features/auth/presentation/view/reset_passwoed_screen.dart';
import 'package:servix/features/home/presentaion/view/home_screen.dart';
import 'package:servix/features/home/domain/entites/category_entity.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';
import 'package:servix/features/home/presentaion/view/professional_details_screen.dart';
import 'package:servix/features/home/presentaion/view/service_details_screen.dart';
import 'package:servix/features/home/presentaion/view/services_screen.dart';
import 'package:servix/features/navbar/presentation/view/navbar_screen.dart';
import 'package:servix/features/onboarding/presentation/view/onboarding_screen.dart.dart';
import 'package:servix/features/splash/presentation/view/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._();
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesNames.splash,

    redirect: (context, state) {
      print("Redirect -> ${state.uri}");
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        name: AppRoutesNames.splash,
        path: AppRoutesNames.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        name: AppRoutesNames.onBoarding,
        path: AppRoutesNames.onBoarding,
        builder: (context, state) => OnboardingScreen(),
      ),

      GoRoute(
        name: AppRoutesNames.login,
        path: AppRoutesNames.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.register,
        path: AppRoutesNames.register,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.forgotPassword,
        path: AppRoutesNames.forgotPassword,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.resetPassword,
        path: AppRoutesNames.resetPassword,
        builder: (context, state) {
          final resetToken = state.uri.queryParameters['resetToken'] ?? '';
          return ResetPasswordScreen(resetToken: resetToken);
        },
      ),
      GoRoute(
        name: AppRoutesNames.otpScreen,
        path: '/otp_screen/:flow',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          final email = state.uri.queryParameters['email'] ?? '';
          final flow = state.pathParameters['flow'] ?? '';
          final verifyType = OtpVerifyType.fromString(flow);
          return OtpScreen(email: email, phone: phone, verifyType: verifyType);
        },
      ),
      GoRoute(
        name: AppRoutesNames.navbar,
        path: AppRoutesNames.navbar,
        builder: (context, state) => const NavbarScreen(),
      ),
      //home
      GoRoute(
        name: AppRoutesNames.home,
        path: AppRoutesNames.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.services,
        path: AppRoutesNames.services,
        builder: (context, state) => const ServicesScreen(),
      ),
    
GoRoute(
  name: AppRoutesNames.professionalDetails,
  path: AppRoutesNames.professionalDetails,
  builder: (context, state) {
    final professional = state.extra as ProfessionalEntity;
    return ProfessionalDetailsScreen(professional: professional);
  },
),
      GoRoute(
        name: AppRoutesNames.serviceDetails,
        path: AppRoutesNames.serviceDetails,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is ProfessionalEntity) {
            return ProfessionalDetailsScreen(professional: extra);
          }
          final category = extra as CategoryEntity;
          return ServiceDetailsScreen(category: category);
        },
      ),
    ],
  );
}
