import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  RemoteConfigService._();

  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: kDebugMode
              ? const Duration(seconds: 10)
              : const Duration(hours: 1),
        ),
      );

      await _remoteConfig.setDefaults({
        'MAPS_API_KEY': '',
        'base_url': 'api.sehtak.com',
        'minimum_version': '1.0.0',
        'recommended_version': '1.0.0',
      });

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Error initializing Remote Config: $e');
    }
  }

  static String getString(String key) {
    return _remoteConfig.getString(key);
  }
}
