import 'package:firebase_messaging/firebase_messaging.dart';
import '../main.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    String? token = await _firebaseMessaging.getToken();
    print('Token: $token');

    handleBackgroundNotification();
  }

  void handleMassage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      "/notification-view",
      arguments: message,
    );
  }

  void handleBackgroundNotification() {
    FirebaseMessaging.instance.getInitialMessage().then(handleMassage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMassage);
  }
}
