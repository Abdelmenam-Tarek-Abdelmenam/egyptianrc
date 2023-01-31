import '../data/repositories/auth_repository.dart';
import '../presentation/shared/toast_helper.dart';

class Failure implements Exception {
  final String message;

  const Failure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory Failure.fromError(Exception exception) {
    if (exception is FireBaseAuthErrors) {
      return Failure(exception.message);
    } else if (exception is Failure) {
      return exception;
    } else {
      return const Failure();
    }
  }

  void get show => showToast(message, type: ToastType.error);
}
