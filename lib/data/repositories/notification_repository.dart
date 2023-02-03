import 'package:dio/dio.dart';
import 'package:egyptianrc/data/error_state.dart';
import 'package:either_dart/either.dart';

const String _fcmKey =
    "AAAAa6x9MxQ:APA91bGIFzbZhapZ5X48Re48Bl83QkoJK0nls-B98rZszs4C-rf_o6zjo8BcaraaEUP-jFz-NcVjk44rE7wjAc3l9l4ZT_Z50NwxQhbzvnuCx2fbfH__cQcacNfM5oEpvexIf9jyEu1M";

class NotificationSender {
  late Dio dio;

  NotificationSender() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/',
      receiveDataWhenStatusError: true,
      connectTimeout: 50000,
      sendTimeout: 50000,
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future<Either<Failure, Response>> postData({
    String path = 'send',
    required Map<String, String> sendData,
    required String title,
    required String body,
    String receiver = "all",
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$_fcmKey',
    };

    Map<String, dynamic> data = {
      "data": sendData,
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
      return Right(await dio.post(path, data: data));
    } on DioError catch (err) {
      return Left(Failure.fromDio(err));
    } catch (_) {
      return const Left(Failure());
    }
  }
}
