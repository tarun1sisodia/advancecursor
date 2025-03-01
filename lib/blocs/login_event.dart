part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailAndPassword(this.email, this.password);
}

