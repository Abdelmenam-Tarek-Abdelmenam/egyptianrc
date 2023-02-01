import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../data/data_sources/pref_repository.dart';
import '../../data/models/app_user.dart';
import '../../data/error_state.dart';
import '../../domain_layer/repository_implementer/sigining_repo.dart';
import '../../presentation/shared/toast_helper.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthBloc extends Bloc<AuthStatusEvent, AuthStates> {
  final SigningRepository _authRepository = SigningRepository();

  AuthBloc(CompleteUser? appUser) : super(AuthStates.initial(appUser)) {
    if (appUser != null) user = appUser.user;

    on<LoginInUsingGoogleEvent>(_loginUsingGoogleHandler);
    on<SignUpInUsingEmailEvent>(_signUpUsingEmailHandler);
    on<LoginInUsingEmailEvent>(_loginUsingEmailHandler);
    on<ForgetPasswordEvent>(_forgetPasswordHandler);
    on<RegisterUserDataEvent>(_registerUserDataHandler);
  }

  bool get loading => [AuthStatus.submittingEmail, AuthStatus.submittingGoogle]
      .contains(state.status);

  static AppUser user = AppUser.empty();

  Future<void> _loginUsingGoogleHandler(
    LoginInUsingGoogleEvent event,
    Emitter<AuthStates> emit,
  ) async {
    if (loading) return;

    emit(state.copyWith(status: AuthStatus.submittingGoogle));
    Either<Failure, CompleteUser> value =
        await _authRepository.signInUsingGoogle();
    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (completeUser) {
      user = completeUser.user;
      if (completeUser.isComplete) {
        PreferenceRepository.putData(
            key: PreferenceKey.userData, value: completeUser.toJson);

        emit(state.copyWith(
          status: AuthStatus.successLogIn,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.successSignUp));
      }
    });
  }

  Future<void> _loginUsingEmailHandler(
    LoginInUsingEmailEvent event,
    Emitter<AuthStates> emit,
  ) async {
    if (loading) return;
    emit(state.copyWith(status: AuthStatus.submittingEmail));
    Either<Failure, CompleteUser> value = await _authRepository
        .signInWithEmailAndPassword(event.email, event.password);

    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (completeUser) {
      user = completeUser.user;
      if (completeUser.isComplete) {
        PreferenceRepository.putData(
            key: PreferenceKey.userData, value: completeUser.toJson);

        emit(state.copyWith(
          status: AuthStatus.successLogIn,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.successSignUp));
      }
    });
  }

  Future<void> _signUpUsingEmailHandler(
    SignUpInUsingEmailEvent event,
    Emitter<AuthStates> emit,
  ) async {
    if (loading) return;

    emit(state.copyWith(status: AuthStatus.submittingEmail));
    Either<Failure, AppUser> value = await _authRepository
        .signUpWithEmailAndPassword(event.email, event.password);
    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (appUser) {
      user = appUser;
      emit(state.copyWith(status: AuthStatus.successSignUp));
    });
  }

  Future<void> _forgetPasswordHandler(
    ForgetPasswordEvent event,
    Emitter<AuthStates> emit,
  ) async {
    if (loading) return;

    Either<Failure, void> value =
        await _authRepository.forgetPassword(event.email);
    value.fold((failure) {
      emit(state.copyWith(status: AuthStatus.error));
      failure.show;
    }, (_) {
      showToast("Password reset email sent to you", type: ToastType.info);
      emit(state.copyWith(status: AuthStatus.doneConfirm));
    });
  }

  Future<void> _registerUserDataHandler(
    RegisterUserDataEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.registerUser));

    user.name = event.name;
    CompleteUser completeUser = CompleteUser(user: user);
    Either<Failure, void> value =
        await _authRepository.registerUser(completeUser);
    value.fold((failure) {
      emit(state.copyWith(status: AuthStatus.error));
      failure.show;
    }, (_) {
      PreferenceRepository.putData(
          key: PreferenceKey.userData, value: completeUser.toJson);
      emit(state.copyWith(status: AuthStatus.successLogIn));
    });
  }
}
