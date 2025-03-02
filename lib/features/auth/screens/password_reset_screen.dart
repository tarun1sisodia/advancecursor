import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_attendance/core/utils/validators.dart';
import 'package:smart_attendance/core/widgets/custom_snackbar.dart';
import 'package:smart_attendance/core/widgets/custom_text_form_field.dart';
import 'package:smart_attendance/features/auth/bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

// void showPasswordResetSuccess(BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text('Password reset link sent successfully!')),
//   );
// }

// void showPasswordResetFailure(BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text('Failed to send password reset link.')),
//   );
// }

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  void _resetPassword() {
    context.read<AuthBloc>().add(
          ResetPassword(email: _emailController.text.trim()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSent) {
            showPasswordResetSuccess(context);
            Navigator.pop(context);
          }
          if (state is AuthError) {
            showPasswordResetFailure(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'Enter your email to receive a password reset link.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: state is AuthLoading ? null : _resetPassword,
                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : const Text('Send Reset Link'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}