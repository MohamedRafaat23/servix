import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_enums.dart';
import 'callback_token.dart';
import '../../di/service_locator.dart';

Future<void> initLocalization() async {
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('locale');
  if (savedLocale != null && savedLocale.isNotEmpty) {
    final languageCode = savedLocale.split('_').first.split('-').first;
    await sl<HandleMulticallLocal>().saveLocalData(
      data: languageCode,
      keyType: LocalEnumKey.languageCode,
    );
  }
}

EasyLocalization localization(Widget app) => EasyLocalization(
  supportedLocales: const [Locale('en'), Locale('ar')],
  path: 'assets/languages',
  fallbackLocale: const Locale('ar'),
  saveLocale: true,
  startLocale: const Locale('en'),
  child: app,
);

List<LocalizationsDelegate<dynamic>> localizationDelegates(
  BuildContext context,
) => context.localizationDelegates;

List<Locale> supportedLocales(BuildContext context) => context.supportedLocales;

Locale locale(BuildContext context) => context.locale;

Future<void> changeLanguage(BuildContext context, String lang) async {
  await context.setLocale(Locale(lang));
  await sl<HandleMulticallLocal>().saveLocalData(
    data: lang,
    keyType: LocalEnumKey.languageCode,
  );
}

extension Translation on String {
  String get trans => this.tr();
}
