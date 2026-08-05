import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/config/theme/app_theme.dart';

import 'config/app_controller/app_controller_bloc.dart';
import 'config/router/app_routes.dart';
import 'core/di/service_locator.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/translation.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServiceLocator();
  await initScreenUtils();
  await initLocalization();

  runApp(
    localization(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilWrapper(
      child: BlocProvider<AppControllerBloc>.value(
        value: sl<AppControllerBloc>(),
        child: BlocBuilder<AppControllerBloc, AppControllerState>(
          builder: (context, state) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoutes.router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          ),
        ),
      ),
    );
  }
}
