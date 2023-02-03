part of "auth_status_bloc.dart";

enum AuthStatus {
  initial,
  loggingOut,
  submittingGoogle,
  gettingUser,
  checkingOtp,
  gettingOtp,
  setOtp,
  successLogIn,
  successSignUp,
  registerUser,
  error,
  finishSession,
}

class AuthStates extends Equatable {
  final AuthStatus status;

  const AuthStates({required this.status});

  factory AuthStates.initial(AppUser? appUser) {
    return const AuthStates(
      status: AuthStatus.initial,
    );
  }

  AuthStates copyWith({AuthStatus? status}) {
    return AuthStates(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
