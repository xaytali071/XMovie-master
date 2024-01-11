import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:xmovie/model/local_storage.dart';

import 'app_widget.dart';

Future<void> backgroundHandler(RemoteMessage message) async{

    String? title = message.notification!.title;
    String? body = message.notification!.body;

  AwesomeNotifications().createNotification(
      content: NotificationContent(id: 123, channelKey: "key1",
      color: Colors.white,
        category: NotificationCategory.Social,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.amber
      ),
  );
}

Future<void> main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "key1",
      channelName: "key2",
      channelDescription: "Channel of call",
    ),
  ],debug: true);
  FirebaseMessaging.onMessageOpenedApp;
  FirebaseMessaging.onMessage;
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocaleStore.init();
  runApp(const AppWidget());
}
