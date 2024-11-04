import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        );
const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin);

Future onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  print('title');
  print('payload');
}

class FirebaseApi {
  // final _firebaseMessaging = FirebaseMessaging.instance;
  // static final AuthenticationRepository authenticationRepository =
  //     AuthenticationRepository();

  static Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print('---FirebaseMessaging.onMessage.listen');

      handleDataInApp(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('---onMessageOpenedApp');
      handleData(message);
    });
    checkOpenAppFromTerminate();
  }

  static Future<void> registerToken() async {
    try {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission(provisional: true);
      } else {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      }
      FirebaseMessaging.instance.getToken().then((token) async {
        print("token firebase $token");
      });
    } catch (e) {
      print(e);
    }
  }

  static void checkOpenAppFromTerminate() async {
    var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    print('terminal ${jsonEncode(initialMessage?.data ?? {})}');
    print('terminal1 ${jsonEncode(initialMessage.toString())}');
    if (initialMessage != null) {
      Future.delayed(const Duration(seconds: 4)).then((value) {
        handleData(initialMessage);
        return;
      });
    }
  }

  Future<void> initNotification() async {
    registerToken();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    // await _firebaseMessaging.requestPermission();
    // final fcMToken = await _firebaseMessaging.getToken();
    // final fcMTokenAPN = await _firebaseMessaging.getAPNSToken();
    // PrefUtil.setTokenFirebase(token: fcMToken ?? '');
    // print('---Fire_Token: $fcMToken');
    // print('---Fire_APN_Token: $fcMTokenAPN');
    initPushNotification();
  }

  static void notificationTapBackground(NotificationResponse details) {
    print('---notificationTapBackground');
  }

  static void handleData(
    RemoteMessage message,
  ) async {
    print("message messs ${message.data}");
  }

  static void handleDataInApp(RemoteMessage message) async {
    print("---message ${message.data.toString()}");
    if (Platform.isAndroid) {
      var notification = message.notification;
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channel.id, channel.name,
          channelDescription: channel.description,
          icon: 'app_icon',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true);
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      flutterLocalNotificationsPlugin.show(
          1, notification?.title, notification?.body, platformChannelSpecifics,
          payload: json.encode(message.data));
    }
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse details) async {
    print('---onDidReceiveNotificationResponse');
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('---handleBackgroundMessage');
  // PrefUtil().
}
