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

    _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        _saveTokenToFirestore(token);
      }
      print('Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      _saveNotificationData(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _saveNotificationData(initialMessage);
    }
  }

  Future<void> _saveTokenToFirestore(String token) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _firestore.collection('students').doc(userId).update({
        'fcmToken': token,
      });
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    await _saveNotificationData(message);
  }

  static Future<void> _saveNotificationData(RemoteMessage message) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(userId)
            .collection('student_notifications')
            .add({
          'title': message.notification?.title ?? 'No Title',
          'body': message.notification?.body ?? 'No Body',
          'sentTime': DateTime.now().toIso8601String(),
          'photoUrl': message.data['photoUrl'] ?? '',
        });
        print('Notification saved successfully');
      } catch (e) {
        print('Error saving notification: $e');
      }
    }
  }
}
