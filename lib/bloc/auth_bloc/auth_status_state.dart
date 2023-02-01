part of "auth_status_bloc.dart";

enum AuthStatus {
  initial,
  submittingGoogle,
  gettingUser,
  checkingOtp,
  gettingOtp,
  setOtp,
  successLogIn,
  successSignUp,
  registerUser,
  error,
}

class AuthStates extends Equatable {
  final AuthStatus status;

  const AuthStates({required this.status});

  factory AuthStates.initial(AppUser? appUser) {
    return const AuthStates(
      status: AuthStatus.initial,
    );
  }

  @override
  List<Object?> get props => [status];

  AuthStates copyWith({AuthStatus? status}) {
    return AuthStates(
      status: status ?? this.status,
    );
  }
}
