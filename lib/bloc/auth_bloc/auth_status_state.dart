part of "auth_status_bloc.dart";

enum AuthStatus {
  initial,
  registerUser,
  submittingEmail,
  submittingGoogle,
  doneConfirm,
  successLogIn,
  successSignUp,
  error,
}

class AuthStates extends Equatable {
  final AuthStatus status;

  const AuthStates({required this.status});

  factory AuthStates.initial(CompleteUser? appUser) {
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
