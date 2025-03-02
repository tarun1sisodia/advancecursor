import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/features/auth/screens/login_screen.dart';
import 'package:smart_attendance/features/home/student_dashboard_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_attendance/firebase_options.dart';
import 'package:smart_attendance/config/theme.dart' as app_theme;
import 'package:smart_attendance/app/routes.dart' as app_routes;

void main() async {
  await dotenv.load(fileName: ".env");

  // Print the loaded environment variables
  /*print('FIREBASE_API_KEY_WEB: ${dotenv.env['FIREBASE_API_KEY_WEB']}');
  print('FIREBASE_APP_ID_WEB: ${dotenv.env['FIREBASE_APP_ID_WEB']}');
  print(
      'FIREBASE_MEASUREMENT_ID_WEB: ${dotenv.env['FIREBASE_MEASUREMENT_ID_WEB']}');
  print('FIREBASE_PROJECT_ID: ${dotenv.env['FIREBASE_PROJECT_ID']}');
  print('FIREBASE_AUTH_DOMAIN: ${dotenv.env['FIREBASE_AUTH_DOMAIN']}');
  print('FIREBASE_STORAGE_BUCKET: ${dotenv.env['FIREBASE_STORAGE_BUCKET']}');
  print('FIREBASE_API_KEY_IOS: ${dotenv.env['FIREBASE_API_KEY_IOS']}');
  print('FIREBASE_APP_ID_IOS: ${dotenv.env['FIREBASE_APP_ID_IOS']}');
  print('FIREBASE_IOS_BUNDLE_ID: ${dotenv.env['FIREBASE_IOS_BUNDLE_ID']}');
  print('FIREBASE_API_KEY_ANDROID: ${dotenv.env['FIREBASE_API_KEY_ANDROID']}');
  print('FIREBASE_APP_ID_ANDROID: ${dotenv.env['FIREBASE_APP_ID_ANDROID']}');
  print(
      'FIREBASE_MESSAGING_SENDER_ID: ${dotenv.env['FIREBASE_MESSAGING_SENDER_ID']}');*/

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Campus',
      theme: app_theme.AppTheme.lightTheme,
      darkTheme: app_theme.AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: app_routes.Routes.generateRoute,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return const StudentDashboardScreen(); // Direct to dashboard if logged in
          } else {
            return const LoginScreen(); // Show onboarding if not logged in
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final user =
        FirebaseAuth.instance.currentUser; // Check if user is logged in
    return hasSeenOnboarding &&
        user != null; // Return true if both conditions are met
  }
}
