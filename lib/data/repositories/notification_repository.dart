import 'package:dio/dio.dart';
import 'package:egyptianrc/data/error_state.dart';

const String _fcmKey = "";

class NotificationSender {
  late Dio dio;

  NotificationSender() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/',
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      sendTimeout: 5000,
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future<Response> postData({
    String path = 'send',
    required Map<String, String> sendData,
    required String receiver,
    required String title,
    required String body,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$_fcmKey',
    };

    Map<String, dynamic> data = {
      "to": "/topics/$receiver",
      "notification": {"title": title, "body": body, "sound": "default"},
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      }
    };

    try {
      return await dio.post(path, data: data);
    } on DioError catch (err) {
      throw Failure.fromDio(err);
    } catch (err) {
      throw const Failure();
    }
  }
}
