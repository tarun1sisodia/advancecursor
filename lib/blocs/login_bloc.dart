import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart'; // Import AuthService

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;

  LoginBloc(this._authService) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailAndPassword) {
      yield LoginLoading();
      try {
        UserCredential userCredential =
            await _authService.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield LoginSuccess(userCredential.user);
      } catch (e) {
        yield LoginFailure(
            'Login failed. Please check your credentials and try again.');
      }
    }
  }
}
