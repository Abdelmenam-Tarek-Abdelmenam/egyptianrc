import 'package:egyptianrc/data/data_sources/web_services/firestore_repository.dart';
import 'package:egyptianrc/data/data_sources/web_services/realtime_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/app_user.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/error_state.dart';

class SigningRepository {
  final AuthRepository _authRepository = AuthRepository();

  Future<Either<Failure, AppUser>> signInUsingGoogle() async {
    try {
      User? user = await _authRepository.signInUsingGoogle();
      if (user != null) {
        return Right(await getUser(user));
      } else {
        return Right(AppUser.empty());
      }
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء عمليه تسجيل الدخول"));
    }
  }

  Future<Either<Failure, void>> getMobileNumberCode(String phone,
      Function(String) callback, Function(Failure) errorHandler) async {
    try {
      if (phone.startsWith("+2")) {
        phone = phone.substring(phone.length - 11, phone.length);
      }
      phone = "+2$phone";
      return Right(await _authRepository.requestMobileVerification(
          phone, callback, errorHandler));
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء عمليه ارسال الرمز"));
    }
  }

  Future<Either<Failure, AppUser>> verifyMobileCode(
      {required String validateCode, required String otp}) async {
    try {
      User? user =
          await _authRepository.checkMobileVerification(validateCode, otp);
      if (user != null) {
        return Right(await getUser(user));
      } else {
        return Right(AppUser.empty());
      }
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء عمليه تاكيد الرمز"));
    }
  }

  Future<Either<Failure, void>> registerUser(AppUser user) async {
    try {
      Map<String, dynamic> data = user.toJson;
      FireStoreRepository repository = FireStoreRepository();
      await repository.setUserInfo(data);
      return const Right(null);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء تسجيل بييانات المستخدم"));
    }
  }

  Future<Either<Failure, AppUser>> getUserInfo(String phone) async {
    try {
      FireStoreRepository repository = FireStoreRepository();
      Map<String, dynamic>? userData = await repository.getUserInfo(phone);
      if (userData != null) {
        bool seen = await RealTimeDataBaseRepository().getSeenInfo();
        return Right(AppUser.fromJson(userData, seen: seen));
      } else {
        return Right(AppUser.empty());
      }
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء الحصول علي بيانات المستخدم"));
    }
  }

  Future<AppUser> getUser(User user) async {
    FireStoreRepository repository = FireStoreRepository();
    Map<String, dynamic>? userData =
        await repository.getUserInfo(user.phoneNumber ?? user.uid);
    if (userData != null) {
      bool seen = await RealTimeDataBaseRepository().getSeenInfo();

      return AppUser.fromJson(userData, seen: seen);
    } else {
      return AppUser.fromFirebaseUser(user);
    }
  }
}
