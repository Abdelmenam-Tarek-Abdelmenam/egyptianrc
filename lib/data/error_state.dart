import 'package:dio/dio.dart';

import '../presentation/resources/string_manager.dart';
import '../presentation/shared/toast_helper.dart';

class Failure implements Exception {
  final String message;

  const Failure([
    this.message = StringManger.defaultError,
  ]);

  factory Failure.fromError(Exception exception) {
    if (exception is Failure) {
      return Failure(exception.message);
    } else if (exception is Failure) {
      return exception;
    } else {
      return const Failure();
    }
  }

  void get show => showToast(message, type: ToastType.error);

  factory Failure.fromDio(DioError error) {
    String message;
    switch (error.type) {
      case DioErrorType.connectTimeout:
        message = 'server not reachable';
        break;
      case DioErrorType.sendTimeout:
        message = 'send Time out';
        break;
      case DioErrorType.receiveTimeout:
        message = 'server not reachable';
        break;
      case DioErrorType.response:
        message = 'the server response, but with a incorrect status';
        break;
      case DioErrorType.cancel:
        message = 'request is cancelled';
        break;
      case DioErrorType.other:
        error.message.contains('SocketException')
            ? message = 'check your internet connection'
            : message = "Unknown error happened";
        break;
    }
    return Failure(message);
  }

  factory Failure.fromFirebaseCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const Failure(
          'Email is not valid or badly formatted.',
        );
      case 'invalid-phone-number':
        return const Failure(
          'Invalid phone number. please check it.',
        );
      case 'Email not verified':
        return const Failure(
          'Email is not verified. please check it.',
        );
      case 'user-disabled':
        return const Failure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const Failure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const Failure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const Failure(
          'Please enter a stronger password.',
        );
      case 'user-not-found':
        return const Failure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const Failure(
          'Incorrect password, please try again.',
        );
      case 'account-exists-with-different-credential':
        return const Failure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const Failure(
          'The credential received is malformed or has expired.',
        );
      case "too-many-requests":
        return const Failure(
          'Too many request , try again later.',
        );
      case 'invalid-verification-code':
        return const Failure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const Failure(
          'The credential verification ID received is invalid.',
        );
      default:
        return Failure(code);
    }
  }
}
