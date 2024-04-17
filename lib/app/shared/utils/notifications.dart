import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


///NOTIFICATIONS

Future<void> requestNotificationPermissions() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // FirebaseMessaging.instance.subscribeToTopic('kolo-ads');
  // FirebaseMessaging.instance.subscribeToTopic('app-update');
  // FirebaseMessaging.instance.subscribeToTopic('keys-update');

  /////////
  //for ios
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  //for android
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

///WHEN FCM NOTIFICATION IS TAPPED EITHER IN FOREGROUND OR BACKGROUND
Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from a terminated state.
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
 //
  }else{
    //
  }

  // Also handle any interaction when the app is in the background via a Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message != null) {
//
    }else{
      //
    }
  });
}


