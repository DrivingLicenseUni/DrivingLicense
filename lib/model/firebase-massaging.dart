import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await Firebase.initializeApp();
    await _firebaseMessaging.requestPermission();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _firebaseMessaging.getToken().then((token) {
      print('Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.messageId}');
      _saveNotificationData(message, _prefs);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('Received an initial message: ${initialMessage.messageId}');
      _saveNotificationData(initialMessage, _prefs);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Received a background message: ${message.messageId}');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _saveNotificationData(message, _prefs);
  }

  static Future<void> _saveNotificationData(RemoteMessage message, SharedPreferences prefs) async {
    String? title = message.notification?.title ?? 'No Title';
    String? body = message.notification?.body ?? 'No Body';
    String sentTime = DateTime.now().toString();

    String? existingNotifications = prefs.getString('notifications');
    List<Map<String, String>> notifications = existingNotifications != null
        ? List<Map<String, String>>.from(json.decode(existingNotifications))
        : [];

    notifications.add({
      'title': title,
      'body': body,
      'sentTime': sentTime,
    });

    await prefs.setString('notifications', json.encode(notifications));
    print('Saved notification: $notifications');
  }
}
