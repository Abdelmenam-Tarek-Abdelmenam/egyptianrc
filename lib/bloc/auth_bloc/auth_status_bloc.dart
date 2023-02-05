import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../data/data_sources/pref_repository.dart';
import '../../data/models/app_user.dart';
import '../../data/error_state.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain_layer/repository_implementer/sigining_repo.dart';
import '../../presentation/resources/string_manager.dart';
part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthBloc extends Bloc<AuthStatusEvent, AuthStates> {
  AuthBloc(AppUser? appUser) : super(AuthStates.initial(appUser)) {
    on<LoginInUsingGoogleEvent>(_loginUsingGoogleHandler);
    on<LoginInAsGuest>(_loginAsGuestHandler);
    on<LoginInUsingPhoneAndPassword>(_loginUsingPhoneHandler);
    on<RequestUserOtpEvent>(_requestOtpEventHandler);
    on<SetVerificationCodeEvent>(_verificationCodeSetter);
    on<SubmitUserOtpEvent>(_submitOtpEventHandler);
    // on<RegisterUserDataEvent>(_registerUserDataHandler);
    on<ThrowErrorEvent>(_handleError);
    on<ResendCodeEvent>(_resendCodeHandler);
    on<GetUserInfoEvent>(_getUserInfo);
    on<LogOutEvent>(_logoutHandler);
    if (appUser != null) {
      user = appUser;
      add(GetUserInfoEvent());
    }
  }

  bool get loading => [
        AuthStatus.submittingGoogle,
        AuthStatus.checkingOtp,
        AuthStatus.gettingOtp
      ].contains(state.status);

  String? verificationCode;

  final SigningRepository _authRepository = SigningRepository();
  static AppUser user = AppUser.empty();

  Future<void> _logoutHandler(LogOutEvent event, Emitter emit) async {
    {
      try {
        emit(state.copyWith(status: AuthStatus.loggingOut));
        await AuthRepository.signOut();
        FirebaseMessaging.instance.unSubscribeToTopicModified(user.subscribeId);
        AuthBloc.user = AppUser.empty();

        emit(state.copyWith(status: AuthStatus.finishSession));
      } catch (_) {
        showToast(StringManger.defaultError);
        emit(state.copyWith(status: AuthStatus.finishSession));
      }
    }
  }

  Future<void> _getUserInfo(GetUserInfoEvent event, Emitter emit) async {
    {
      emit(state.copyWith(status: AuthStatus.gettingUser));
      Either<Failure, AppUser> value =
          await _authRepository.getUserInfo(user.id);

      await value.fold((failure) {
        failure.show;
        emit(state.copyWith(status: AuthStatus.error));
      }, (completeUser) async {
        completeUser.id = user.id;
        user = completeUser;
        if (user.panned) {
          showToast(StringManger.panned);
          AuthRepository.signOut();
          FirebaseMessaging.instance
              .unSubscribeToTopicModified(user.subscribeId);
          emit(state.copyWith(status: AuthStatus.finishSession));
        } else {
          FirebaseMessaging.instance.subscribeToTopicModified(user.subscribeId);
          PreferenceRepository.putData(
              key: PreferenceKey.userData, value: completeUser.toJson);
        }
      });
    }
  }

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
        if (user.panned) {
          FirebaseMessaging.instance
              .unSubscribeToTopicModified(user.subscribeId);
          showToast(StringManger.panned);
          AuthRepository.signOut();
          user = AppUser.empty();

          emit(state.copyWith(status: AuthStatus.finishSession));
        } else if (user.password == event.pass) {
          PreferenceRepository.putData(
              key: PreferenceKey.userData, value: user.toJson);
          FirebaseMessaging.instance.subscribeToTopicModified(user.subscribeId);
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
        if (user.panned) {
          showToast(StringManger.panned);
          AuthRepository.signOut();
          user = AppUser.empty();
          emit(state.copyWith(status: AuthStatus.finishSession));
        } else {
          PreferenceRepository.putData(
              key: PreferenceKey.userData, value: completeUser.toJson);
          FirebaseMessaging.instance.subscribeToTopicModified(user.subscribeId);
          emit(state.copyWith(status: AuthStatus.successLogIn));
        }
      } else {
        await _authRepository.registerUser(user);
        FirebaseMessaging.instance.subscribeToTopicModified(user.subscribeId);
        emit(state.copyWith(status: AuthStatus.successSignUp));
      }
    });
  }

  Future<void> _loginAsGuestHandler(LoginInAsGuest event, Emitter emit) async {
    user = AppUser(id: "temp${event.phone}", phoneNumber: event.phone);
    FirebaseMessaging.instance.subscribeToTopicModified(user.subscribeId);
    PreferenceRepository.putData(
        key: PreferenceKey.userData, value: user.toJson);
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
          await _authRepository.registerUser(user);
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

extension on FirebaseMessaging {
  Future<void> subscribeToTopicModified(String topic) async {
    if (kIsWeb) return;

    subscribeToTopic(topic);
  }

  Future<void> unSubscribeToTopicModified(String topic) async {
    if (kIsWeb) return;

    unsubscribeFromTopic(topic);
  }
}
