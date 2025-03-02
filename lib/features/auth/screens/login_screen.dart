import 'package:flutter/material.dart';
import 'package:smart_attendance/app/routes.dart';
import 'package:smart_attendance/config/app_config.dart';
import 'package:smart_attendance/config/app_pallete.dart';
import 'package:smart_attendance/core/utils/validators.dart';
import 'package:smart_attendance/core/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:smart_attendance/core/widgets/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  double _opacity = 0.0;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fade in effect
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        // Show success message
        showLoginSuccess(context);

        // Navigate to the main app screen
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    } catch (e) {
      showLoginFailure(context); // Use the updated snackbar function
    }
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Show success message
      showLoginSuccess(context);

      // Navigate to the main app screen
      Navigator.pushReplacementNamed(context, Routes.home);
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes
      if (e.code == 'invalid-credential') {
        showLoginFailure(context); // Use the updated snackbar function
      } else if (e.message ==
          'The supplied auth credential is incorrect, malformed or has expired.') {
        showLoginFailure(context); // Use the updated snackbar function
      } else {
        // Handle other errors
        showLoginFailure(context); // Use the updated snackbar function
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Join our community and Experience a seamless tracking your relationship',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _passwordController,
                  label: 'Password',
                  validator: Validators.validatePassword,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Apppallete.lightGrey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple, Colors.yellowAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _handleLogin();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _handleGoogleSignIn,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.yellow),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.g_mobiledata, color: Colors.grey),
                    label: const Text(
                      'Login with Google',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Haven't registered yet?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Apppallete.lightGrey),
                      ),
                    ),
                  ],
                ),
                // Debug button for testing onboarding
                if (const bool.fromEnvironment('dart.vm.product') == false)
                  TextButton(
                    onPressed: () async {
                      await AppConfig.clearOnboardingState();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.splash,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Reset Onboarding (Debug)',
                      style: TextStyle(color: Apppallete.lightGrey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
