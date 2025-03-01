import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../services/auth_service.dart';
import '../../../app/routes.dart';
import '../../../blocs/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _isLoading = false;
  double _opacity = 0.0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthService()),
      child: Scaffold(
        body: SafeArea(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Welcome Back',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      controller: _emailController,
                      label: 'Email',
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefix: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _passwordController,
                      label: 'Password',
                      validator: Validators.validatePassword,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      prefix: const Icon(Icons.lock_outlined),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) async {
                        if (state is LoginSuccess) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);
                          Navigator.pushReplacementNamed(
                              context, Routes.studentDashboard);
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.red),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginWithEmailAndPassword(
                                        _emailController.text.trim(),
                                        _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            child: const Text('Login'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Lottie.network(
                        "https://lottie.host/81aa7827-1538-435e-9ed4-3a1dbedb1042/7mFMYAtB4y.lottie",
                        fit: BoxFit.fill,
                        onLoaded: (composition) {
                          // Optionally handle the loaded composition
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleGoogleSignIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Lottie.network(
                                "https://lottie.host/b4874990-b0f1-4638-958f-0ddde8192825/89234oDu2a.lottie", // Google logo animation URL
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('Sign in with Google'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.register);
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, Routes.studentDashboard);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: ${e.toString()}')),
      );
    }
  }
}
