import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../repository/post_fcm/model/post_fcm_request.dart';
import '../../repository/post_fcm/post_fcm.dart';

String _deviceType() {
  if (kIsWeb) return 'web';
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'android';
    case TargetPlatform.iOS:
      return 'ios';
    default:
      return 'android';
  }
}
  

class NotificationServices {
  static bool _initialized = false;

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (kDebugMode) {
          print('Notification clicked with id: ${response.id}');
        }
        if (response.payload != null) {
          final Map<String, dynamic> data = json.decode(response.payload!);
          _handleNotificationClick(data);
        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Request permission for iOS/Android
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print(
            'Message also contained a notification: ${message.notification}',
          );
        }
        showLocalNotification(message);
      }
    });

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message.data);
    });

    // Check for initial message
    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(message.data);
      }
    });

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh
        .listen((fcmToken) {
          _sendTokenToServer(fcmToken);
        })
        .onError((err) {
          if (kDebugMode) {
            print('Error getting token on refresh: $err');
          }
        });

    // Get initial token
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        _sendTokenToServer(token);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get FCM token: $e');
      }
    }
  }

  static void showLocalNotification(RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
      title: message.notification!.title,
      id: 0,
      body: message.notification!.body,
      payload: json.encode(message.data),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@drawable/ic_notification',
          color: Colors.white,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  static void _handleNotificationClick(Map<String, dynamic> data) {
   
  }

  static void _sendTokenToServer(String token) {
    if (kDebugMode) {
      print('FCM Token: $token');
    }
    final model = PostFcmRequestModel(
      registrationId: token,
      type: _deviceType(),
    );
    postFcmMethod(model: model);
  }
}
