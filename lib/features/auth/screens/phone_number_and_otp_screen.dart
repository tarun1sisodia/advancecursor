import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/app/routes.dart';
import 'package:smart_attendance/core/widgets/custom_text_form_field.dart';
import 'package:smart_attendance/core/widgets/custom_snackbar.dart';

class PhoneNumberAndOtpScreen extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const PhoneNumberAndOtpScreen(
      {Key? key,
      required this.email,
      required this.password,
      required this.username})
      : super(key: key);

  @override
  _PhoneNumberAndOtpScreenState createState() =>
      _PhoneNumberAndOtpScreenState();
}

class _PhoneNumberAndOtpScreenState extends State<PhoneNumberAndOtpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId;
  bool _isOtpSent = false;
  bool _isLoading = false;

  void _sendCode() async {
    String phoneNumber = _phoneController.text.trim();
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        } catch (e) {
          if (mounted) {
            showCustomSnackbar(context, 'Error: ${e.toString()}');
          }
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        showCustomSnackbar(context, 'Error: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isOtpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _verifyOTP() async {
    setState(() => _isLoading = true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      showCustomSnackbar(context, 'OTP verified successfully!');
      Navigator.pushReplacementNamed(context, Routes.studentDashboard);
    } catch (e) {
      showCustomSnackbar(context, 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number & OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            ElevatedButton(
              onPressed: _isLoading ? null : _sendCode,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Send me the code'),
            ),
            const SizedBox(height: 20),
            if (_isOtpSent) ...[
              CustomTextFormField(
                controller: _otpController,
                label: 'Enter OTP',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyOTP,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Verify OTP'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
