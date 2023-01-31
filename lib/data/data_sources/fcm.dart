import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import '../../presentation/shared/toast_helper.dart';

class FireNotificationHelper {
//  static Future<String?> get token => FirebaseMessaging.instance.getToken();
  final Function(Map<String, dynamic>) _callback;

  FireNotificationHelper(this._callback) {
    FirebaseMessaging.instance.subscribeToTopic("all").catchError((err) {});

    FirebaseMessaging.onMessage
        .listen(_firebaseMessagingForegroundHandler)
        .onError((err) {});
    FirebaseMessaging.onMessageOpenedApp
        .listen(_firebaseMessagingBackgroundHandler)
        .onError((err) {});
    FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundCloseHandler);
  }

  Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    Vibrate.vibrate();
    notificationCallback(message.data);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    notificationCallback(message.data);
  }

  Future<void> notificationCallback(Map<String, dynamic> data) async {
    showToast("Notification come", type: ToastType.info);
    _callback(data);
  }
}

Future<void> _firebaseMessagingBackgroundCloseHandler(
    RemoteMessage message) async {}
