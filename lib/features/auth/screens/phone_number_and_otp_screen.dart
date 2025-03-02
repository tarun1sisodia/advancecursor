import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_attendance/app/routes.dart';
import 'package:smart_attendance/core/widgets/custom_text_form_field.dart';
import 'package:smart_attendance/core/widgets/custom_snackbar.dart';
import 'package:smart_attendance/features/auth/bloc/auth_bloc.dart';

// Screen for phone verification after registration
class PhoneNumberAndOtpScreen extends StatefulWidget {
  // Required user data passed from registration screen
  final String email;
  final String password;
  final String username;

  const PhoneNumberAndOtpScreen({
    Key? key,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);

  @override
  _PhoneNumberAndOtpScreenState createState() => _PhoneNumberAndOtpScreenState();
}

class _PhoneNumberAndOtpScreenState extends State<PhoneNumberAndOtpScreen> {
  // Controllers for input fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  
  // Track if OTP has been sent
  bool _isOtpSent = false;

  // Trigger phone number verification
  void _sendCode() {
    final phoneNumber = _phoneController.text.trim();
    // Dispatch event to AuthBloc for phone verification
    context.read<AuthBloc>().add(VerifyPhoneNumber(phoneNumber: phoneNumber));
  }

  // Verify OTP entered by user
  void _verifyOTP(String verificationId) {
    context.read<AuthBloc>().add(
      CompleteRegistration(
        otp: _otpController.text.trim(),
        verificationId: verificationId,
        email: widget.email,
        password: widget.password,
        username: widget.username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number & OTP Verification')),
      // Listen to AuthBloc states for verification progress
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Handle different verification states
          if (state is PhoneNumberVerified) {
            setState(() => _isOtpSent = true);
            showCustomSnackbar(context, 'OTP sent successfully!');
          }
          if (state is OTPVerified) {
            showCustomSnackbar(context, 'Phone number verified successfully!');
            Navigator.pushReplacementNamed(context, Routes.studentDashboard);
          }
          if (state is AuthError) {
            showCustomSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Phone number input field
                CustomTextFormField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Send OTP button
                ElevatedButton(
                  onPressed: state is AuthLoading ? null : _sendCode,
                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : const Text('Send me the code'),
                ),
                const SizedBox(height: 20),
                // Show OTP input field after phone verification
                if (_isOtpSent) ...[
                  CustomTextFormField(
                    controller: _otpController,
                    label: 'Enter OTP',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  // Verify OTP button
                  ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () => _verifyOTP(
                              (state as PhoneNumberVerified).verificationId,
                            ),
                    child: state is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text('Verify OTP'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}