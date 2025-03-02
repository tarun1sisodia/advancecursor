import 'package:flutter/material.dart';
import 'package:smart_attendance/features/attendance/screens/attendance_screen.dart';
import 'package:smart_attendance/features/auth/screens/login_screen.dart';
import 'package:smart_attendance/features/auth/screens/password_reset_screen.dart';
import 'package:smart_attendance/features/auth/screens/onboarding_screen.dart';
import 'package:smart_attendance/features/auth/screens/phone_number_and_otp_screen.dart';
import 'package:smart_attendance/features/auth/screens/registration_screen.dart';
import 'package:smart_attendance/features/home/student_dashboard_screen.dart';
import 'package:smart_attendance/features/profile/student_profile_screen.dart';
import 'package:smart_attendance/features/settings/screens/settings_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String studentDashboard = '/student-dashboard';
  static const String studentProfile = '/student-profile';
  static const String markAttendance = '/mark-attendance';
  static const String syncStatus = '/sync-status';
  static const String about = '/about';
  static const String sentryTest = '/sentry-test';
  static const String attendance = '/attendance';
  static const String phoneNumberAndOtp = '/phone-number-and-otp';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      studentDashboard: (context) => const StudentDashboardScreen(),
      phoneNumberAndOtp: (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as VerificationArguments;
        return PhoneNumberAndOtpScreen(
          email: args.email,
          password: args.password,
          username: args.username,
        );
      },
      // attendance: (context) => AttendanceScreen(),
      studentProfile: (context) => StudentProfileScreen(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/phone-number-and-otp':
        final args = settings.arguments as VerificationArguments;
        return MaterialPageRoute(
          builder: (_) => PhoneNumberAndOtpScreen(
            email: args.email,
            password: args.password,
            username: args.username,
          ),
        );
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case '/student-profile':
        return MaterialPageRoute(builder: (_) => StudentProfileScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      // case '/sync-status':
      //   return MaterialPageRoute(builder: (_) => const SyncStatusScreen());
      // case '/about':
      //   return MaterialPageRoute(builder: (_) => const AboutScreen());
      // case '/sentry-test':
      //   return MaterialPageRoute(builder: (_) => const SentryTestScreen());
      case '/student-dashboard':
        return MaterialPageRoute(
            builder: (_) => const StudentDashboardScreen());
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static void navigateToAndRemove(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          switch (routeName) {
            case '/onboarding':
              return const OnboardingScreen();
            case '/login':
              return const LoginScreen();
            case '/register':
              return const RegisterScreen();

            case '/forgot-password':
              return const ForgotPasswordScreen();
            case '/student-profile':
              return StudentProfileScreen();
            case '/settings':
              return const SettingsScreen();
            case '/student-dashboard':
              return const StudentDashboardScreen();

            // case '/sync-status':
            //   return const SyncStatusScreen();
            // case '/about':
            //   return const AboutScreen();
            // case '/sentry-test':
            //   return const SentryTestScreen();
            default:
              throw Exception('Invalid route: $routeName');
          }
        },
      ),
      (route) => false,
    );
  }
}

class RegistrationArguments {
  final String email;
  final String password;
  final String username;

  RegistrationArguments({
    required this.email,
    required this.password,
    required this.username,
  });
}

class VerificationArguments {
  final String verificationId;
  final String email;
  final String password;
  final String username;

  VerificationArguments({
    required this.verificationId,
    required this.email,
    required this.password,
    required this.username,
  });
}

// Placeholder screens - these will be replaced with actual implementations
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Auto-navigate to login after a delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Add your app logo here
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Smart Attendance',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
