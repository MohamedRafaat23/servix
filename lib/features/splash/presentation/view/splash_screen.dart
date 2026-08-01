import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/utils/functions/router_handler.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/features/splash/presentation/splash_bloc/splash_bloc.dart';
import 'package:servix/features/splash/presentation/splash_bloc/splash_event.dart';
import 'package:servix/features/splash/presentation/splash_bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashBloc>()..add(const SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.authenticated) {
            RouterHandler.navigate(
              context,
              AppRoutesNames.login,
              routerType: RouterType.goAndPopAll,
            );
          } else if (state.status == SplashStatus.unauthenticated) {
            RouterHandler.navigate(
              context,
              AppRoutesNames.onBoarding,
              routerType: RouterType.goAndPopAll,
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              AppImages.logoServix,
              width: context.byDevice(
                mobilePortrait: 140.width,
                mobileLandscape: 160.width,
                tablet: 220.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}