import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel_v2',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
  playSound: true,
);

@pragma('vm:entry-point')
void _onLocalNotificationTapBackground(NotificationResponse response) {
  debugPrint("Background notification tap: ${response.payload}");
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification == null && message.data.isNotEmpty) {
    await PushNotificationService._showLocalNotification(message);
  }
}

class PushNotificationService {
  final HomeRepo homeRepo;

  PushNotificationService({required this.homeRepo});

  Future<void> initialize() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      const AndroidInitializationSettings androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings iosInit =
          DarwinInitializationSettings();

      const InitializationSettings initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _localNotificationsPlugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          debugPrint("Foreground notification tap: ${response.payload}");
        },
        onDidReceiveBackgroundNotificationResponse:
            _onLocalNotificationTapBackground,
      );

      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);

      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        final result = await homeRepo.sendDeviceToken(token: token);
        result.fold(
          (failure) => debugPrint("Failed to send token: ${failure.errorMsg}"),
          (_) => debugPrint("Token saved successfully"),
        );
      }
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    String title = '';
    String body = '';

    if (message.data.isNotEmpty) {
      String type = message.data['type'] ?? '';

      switch (type) {
        case 'offer_accepted':
          title = 'تم قبول عرضك';
          body = 'تم قبول عرض المساعدة الأونلاين/الأوفلاين الخاص بك بنجاح.';
          break;
        case 'offer_rejected':
          title = 'تم رفض عرضك';
          body = 'للأسف تم رفض عرض المساعدة الذي قدمته.';
          break;
        case 'chat':
          String senderName = message.data['sender_name'] ?? 'مستخدم';
          title = 'رسالة جديدة من $senderName';
          body = 'وصلتك رسالة جديدة في الشات.';
          break;
        case 'welcome':
          title = 'أهلاً بك في MotoVerse';
          body = 'يسعدنا انضمامك إلينا! نتمنى لك استفادة كاملة.';
          break;
        default:
          title = message.data['title'] ?? '';
          body = message.data['body'] ?? '';
      }
    }

    if (title.isEmpty) {
      title = message.notification?.title ?? 'إشعار جديد';
    }
    if (body.isEmpty) {
      body =
          message.notification?.body ?? 'تفقد التطبيق لرؤية التحديثات الجديدة.';
    }

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon:
          '@mipmap/ic_launcher', 
      styleInformation: bigTextStyleInformation,
      color: AppColors.whiteLight,
      colorized: true,
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotificationsPlugin.show(
      id: message.hashCode,
      title: title,
      body: body,
      notificationDetails: platformDetails,
      payload: message.data['type'] ?? 'default_payload',
    );
  }
}
