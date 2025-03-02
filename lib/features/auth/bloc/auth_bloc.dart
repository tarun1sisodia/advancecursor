import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<LoginWithEmailPassword>(_handleEmailPasswordLogin);
    on<LoginWithGoogle>(_handleGoogleLogin);
    on<ResetPassword>(_handlePasswordReset);
    on<VerifyPhoneNumber>(_handlePhoneVerification);
    on<CompleteRegistration>(_handleCompleteRegistration);
    on<LogoutUser>(_handleLogout);
  }

  Future<void> _handleEmailPasswordLogin(
      LoginWithEmailPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user: userCredential.user!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _handleGoogleLogin(
    LoginWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential = await _auth.signInWithCredential(credential);
        emit(AuthSuccess(user: userCredential.user!));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Future<void> _handleRegistration(
  //     RegisterUser event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     final userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: event.email, password: event.password);
  //     // Add username to user profile
  //     await userCredential.user?.updateDisplayName(event.username);
  //     emit(AuthSuccess(user: userCredential.user!));
  //   } catch (e) {
  //     emit(AuthError(message: e.toString()));
  //   }
  // }

  Future<void> _handlePasswordReset(
    ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(
        email: event.email,
      );
      emit(PasswordResetSent());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _handlePhoneVerification(
    VerifyPhoneNumber event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(
            AuthError(message: e.message ?? 'Verification failed'),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(PhoneNumberVerified(
            verificationId: verificationId,
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Future<void> _handleOTPVerification(
  //     VerifyOTP event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     final credential = PhoneAuthProvider.credential(
  //       verificationId: event.verificationId,
  //       smsCode: event.otp,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     emit(OTPVerified());
  //   } catch (e) {
  //     emit(AuthError(message: e.toString()));
  //   }
  // }

  Future<void> _handleLogout(LogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _handleCompleteRegistration(
    CompleteRegistration event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // First verify the OTP
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );

      // Create user account after OTP verification
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Update user profile
      await userCredential.user?.updateDisplayName(event.username);

      // Link phone credential with user account
      await userCredential.user?.linkWithCredential(credential);

      emit(AuthSuccess(user: userCredential.user!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}

// Add this event handler
