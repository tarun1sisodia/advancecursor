part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginWithEmailPassword extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailPassword({required this.email, required this.password});
}

class LoginWithGoogle extends AuthEvent {}

class VerifyPhoneNumber extends AuthEvent {
  final String phoneNumber;
  VerifyPhoneNumber({required this.phoneNumber});
}

class CompleteRegistration extends AuthEvent {
  final String otp;
  final String verificationId;
  final String email;
  final String password;
  final String username;

  CompleteRegistration({
    required this.otp,
    required this.verificationId,
    required this.email,
    required this.password,
    required this.username,
  });
}

class LogoutUser extends AuthEvent {}

class ResetPassword extends AuthEvent {
  final String email;
  ResetPassword({required this.email});
}
