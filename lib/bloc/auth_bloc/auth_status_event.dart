part of "auth_status_bloc.dart";

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object?> get props => [];
}

class LoginInUsingGoogleEvent extends AuthStatusEvent {}

class LoginInAsGuest extends AuthStatusEvent {
  final String phone;
  const LoginInAsGuest(this.phone);
}

class LoginInUsingPhoneAndPassword extends AuthStatusEvent {
  final String phone;
  final String pass;
  const LoginInUsingPhoneAndPassword(this.phone, this.pass);

  @override
  List<Object?> get props => [phone, pass];
}

class ResendCodeEvent extends AuthStatusEvent {
  @override
  List<Object?> get props => [0];
}

class GetUserInfoEvent extends AuthStatusEvent {
  @override
  List<Object?> get props => [0];
}

class LogOutEvent extends AuthStatusEvent {
  @override
  List<Object?> get props => [0];
}

class ThrowErrorEvent extends AuthStatusEvent {
  final Failure failure;
  const ThrowErrorEvent(this.failure);

  @override
  List<Object?> get props => [failure.message];
}

// class RegisterUserDataEvent extends AuthStatusEvent {
//   final String name;
//   const RegisterUserDataEvent(this.name);
//
//   @override
//   List<Object?> get props => [name];
// }

class SetVerificationCodeEvent extends AuthStatusEvent {
  final String code;
  const SetVerificationCodeEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class RequestUserOtpEvent extends AuthStatusEvent {
  final String phone;
  final String password;
  final String name;
  const RequestUserOtpEvent(this.phone, this.password, this.name);

  @override
  List<Object?> get props => [phone, password, name];
}

class SubmitUserOtpEvent extends AuthStatusEvent {
  final String otp;
  const SubmitUserOtpEvent(this.otp);

  @override
  List<Object?> get props => [otp];
}

class LoginInUsingEmailEvent extends AuthStatusEvent {
  final String email;
  final String password;

  const LoginInUsingEmailEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpInUsingEmailEvent extends AuthStatusEvent {
  final String email;
  final String password;

  const SignUpInUsingEmailEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class ForgetPasswordEvent extends AuthStatusEvent {
  final String email;

  const ForgetPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}
