import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../data/data_sources/pref_repository.dart';
import '../../data/models/app_user.dart';
import '../../data/error_state.dart';
import '../../domain_layer/repository_implementer/sigining_repo.dart';
import '../../presentation/resources/string_manager.dart';
part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthBloc extends Bloc<AuthStatusEvent, AuthStates> {
  AuthBloc(AppUser? appUser) : super(AuthStates.initial(appUser)) {
    if (appUser != null) user = appUser;

    on<LoginInUsingGoogleEvent>(_loginUsingGoogleHandler);
    on<LoginInAsGuest>(_loginAsGuestHandler);
    on<LoginInUsingPhoneAndPassword>(_loginUsingPhoneHandler);
    on<RequestUserOtpEvent>(_requestOtpEventHandler);
    on<SetVerificationCodeEvent>(_verificationCodeSetter);
    on<SubmitUserOtpEvent>(_submitOtpEventHandler);
    // on<RegisterUserDataEvent>(_registerUserDataHandler);
    on<ThrowErrorEvent>(_handleError);
    on<ResendCodeEvent>(_resendCodeHandler);
  }

  bool get loading => [
        AuthStatus.submittingGoogle,
        AuthStatus.checkingOtp,
        AuthStatus.gettingOtp
      ].contains(state.status);

  String? verificationCode;

  final SigningRepository _authRepository = SigningRepository();
  static AppUser user = AppUser.empty();

  Future<void> _loginUsingPhoneHandler(
      LoginInUsingPhoneAndPassword event, Emitter emit) async {
    if (loading) return;

    emit(state.copyWith(status: AuthStatus.gettingUser));
    Either<Failure, AppUser> value =
        await _authRepository.getUserInfo(event.phone);

    await value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (completeUser) async {
      user = completeUser;
      if (user.isEmpty) {
        showToast(StringManger.noAccount);
        emit(state.copyWith(status: AuthStatus.error));
      } else {
        if (user.password == event.pass) {
          PreferenceRepository.putData(
              key: PreferenceKey.userData, value: user.toJson);
          emit(state.copyWith(status: AuthStatus.successLogIn));
        } else {
          showToast(StringManger.wrongPass);
          emit(state.copyWith(status: AuthStatus.error));
        }
      }
    });
  }

  Future<void> _loginUsingGoogleHandler(
      LoginInUsingGoogleEvent event, Emitter emit) async {
    if (loading) return;

    emit(state.copyWith(status: AuthStatus.submittingGoogle));
    Either<Failure, AppUser> value = await _authRepository.signInUsingGoogle();

    await value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (completeUser) async {
      user = completeUser;

      if (completeUser.isEmpty) {
        emit(state.copyWith(status: AuthStatus.error));
      } else if (completeUser.isComplete) {
        PreferenceRepository.putData(
            key: PreferenceKey.userData, value: completeUser.toJson);
        emit(state.copyWith(status: AuthStatus.successLogIn));
      } else {
        await _authRepository.registerUser(user);
        emit(state.copyWith(status: AuthStatus.successSignUp));
      }
    });
  }

  Future<void> _loginAsGuestHandler(LoginInAsGuest event, Emitter emit) async {
    user = AppUser(id: user.id);
    emit(state.copyWith(status: AuthStatus.successLogIn));
  }

  Future<void> _requestOtpEventHandler(
      RequestUserOtpEvent event, Emitter<AuthStates> emit) async {
    if (loading) return;
    emit(state.copyWith(status: AuthStatus.gettingOtp));
    Either<Failure, void> value = await _authRepository.getMobileNumberCode(
        event.phone,
        (code) => add(SetVerificationCodeEvent(code)),
        (failure) => add(ThrowErrorEvent(failure)));
    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (_) {
      user
        ..password = event.password
        ..name = event.name
        ..phoneNumber = event.phone;
    });
  }

  void _resendCodeHandler(ResendCodeEvent _, Emitter<AuthStates> emit) async {
    if (loading) return;
    emit(state.copyWith(status: AuthStatus.gettingOtp));
    Either<Failure, void> value = await _authRepository.getMobileNumberCode(
        user.phoneNumber!,
        (code) => add(SetVerificationCodeEvent(code)),
        (failure) => add(ThrowErrorEvent(failure)));
    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (_) {});
  }

  void _verificationCodeSetter(
      SetVerificationCodeEvent event, Emitter<AuthStates> emit) {
    verificationCode = event.code;
    emit(state.copyWith(status: AuthStatus.setOtp));
  }

  void _handleError(ThrowErrorEvent event, Emitter<AuthStates> emit) {
    event.failure.show;
    emit(state.copyWith(status: AuthStatus.error));
  }

  Future<void> _submitOtpEventHandler(
      SubmitUserOtpEvent event, Emitter<AuthStates> emit) async {
    if (loading) return;

    emit(state.copyWith(status: AuthStatus.checkingOtp));
    if (verificationCode != null) {
      Either<Failure, AppUser> value = await _authRepository.verifyMobileCode(
          validateCode: verificationCode!, otp: event.otp);
      await value.fold((failure) {
        failure.show;
        emit(state.copyWith(status: AuthStatus.error));
      }, (completeUser) async {
        completeUser
          ..password = user.password
          ..name = user.name
          ..phoneNumber = user.phoneNumber;
        user = completeUser;

        if (completeUser.isEmpty) {
          showToast(StringManger.wrongCode);
          emit(state.copyWith(status: AuthStatus.error));
        } else if (completeUser.isComplete) {
          PreferenceRepository.putData(
              key: PreferenceKey.userData, value: user.toJson);
          emit(state.copyWith(status: AuthStatus.successLogIn));
        } else {
          await _authRepository.registerUser(user);
          emit(state.copyWith(status: AuthStatus.successSignUp));
        }
      });
    } else {
      showToast(StringManger.verificationFailed);
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  // Future<void> _registerUserDataHandler(
  //   RegisterUserDataEvent event,
  //   Emitter<AuthStates> emit,
  // ) async {
  //   emit(state.copyWith(status: AuthStatus.registerUser));
  //
  //   Either<Failure, void> value = await _authRepository.registerUser(user);
  //   value.fold((failure) {
  //     emit(state.copyWith(status: AuthStatus.error));
  //     failure.show;
  //   }, (_) {
  //     PreferenceRepository.putData(
  //         key: PreferenceKey.userData, value: user.toJson);
  //     emit(state.copyWith(status: AuthStatus.successLogIn));
  //   });
  // }
}
