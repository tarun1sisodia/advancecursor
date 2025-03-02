part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess({required this.user});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class PasswordResetSent extends AuthState {}

class PhoneNumberVerified extends AuthState {
  final String verificationId;
  PhoneNumberVerified({required this.verificationId});
}

class OTPVerified extends AuthState {}
