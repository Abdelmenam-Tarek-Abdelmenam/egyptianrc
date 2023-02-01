import 'package:dio/dio.dart';
import 'package:egyptianrc/data/error_state.dart';

const String _accessToken = "";

class NotificationSender {
  late Dio dio;

  NotificationSender() {
    dio = Dio(BaseOptions(
      baseUrl:
          'https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send',
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      sendTimeout: 5000,
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future<Response> postData({
    String path = 'messages:send',
    required Map<String, String> sendData,
    required String receiver,
    required String title,
    required String body,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };

    Map<String, dynamic> data = {
      "message": {
        "topic": receiver,
        "notification": {"title": title, "body": body},
        "data": sendData
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
