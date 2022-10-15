import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('app_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onSelectNotification: (String? payload) async {

    });

    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      //("remote message ${message}");
      showTextNotification(message,flutterLocalNotificationsPlugin);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //  print("remote messages ${message}");
      showTextNotification(message,flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //  print("remote messagess ${message}");
      showTextNotification(message,flutterLocalNotificationsPlugin);
    });
  }

  static Future<void> showTextNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.acoride.customer', 'Acoride', channelDescription:  'big text channel description',
      importance: Importance.high, priority: Priority.high, enableLights: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, message.notification?.title, message.notification?.body, platformChannelSpecifics, payload: "1");
  }


  static Future<dynamic> saveDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final String? fcmToken = await firebaseMessaging.getToken();
    debugPrint("FCM Token: $fcmToken");
    return fcmToken;
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  var androidInitialize = const AndroidInitializationSettings('app_icon');
  var iOSInitialize = const IOSInitializationSettings();
  var initializationsSettings =  InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // FirebaseNotifications.saveDeviceToken();
}