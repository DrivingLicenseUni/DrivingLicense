import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initNotifications() async {
    await Firebase.initializeApp();
    await _firebaseMessaging.requestPermission();

    // Save FCM token
    _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        _saveTokenToFirestore(token);
      }
      print('Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.messageId}');
      _saveNotificationData(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('Received an initial message: ${initialMessage.messageId}');
      _saveNotificationData(initialMessage);
    }
  }

  Future<void> _saveTokenToFirestore(String token) async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _firestore.collection('students').doc(userId).update({
        'fcmToken': token,
      });
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Received a background message: ${message.messageId}');
    await _saveNotificationData(message);
  }

  static Future<void> _saveNotificationData(RemoteMessage message) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(userId)
          .collection('notifications')
          .add({
        'title': message.notification?.title ?? 'No Title',
        'body': message.notification?.body ?? 'No Body',
        'sentTime': DateTime.now().toIso8601String(),
      });
    }
  }
}
