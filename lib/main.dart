import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/utils/colors.dart';
import 'app/shared/utils/notifications.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await requestNotificationPermissions();

  //for receiving fcm messages in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //for receiving fcm messages in foreground
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    RemoteMessage? remoteMessage = message;
    print("fcm data: ${message.data}");
    //setupInteractedMessage();
    if (notification != null && message.notification?.android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              icon: "@mipmap/ic_launcher", //android.smallIcon
            ),
          ));
    }
  });


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kBgColor,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kWhiteColor),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.kWhiteColor,
        ),
        fontFamily: 'grotesk',
      ),
      debugShowCheckedModeBanner: false,
      title: "UniLecture",
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("fcm notification: title - ${message.notification?.title}, body - ${message.notification?.body}");
  print("fcm data: ${message.data}");
}
