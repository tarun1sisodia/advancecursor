import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/blocs/onboarding/bloc/onboarding_bloc.dart';
import 'package:smart_attendance/features/auth/bloc/auth_bloc.dart';
import 'package:smart_attendance/features/auth/screens/login_screen.dart';
import 'package:smart_attendance/features/home/student_dashboard_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_attendance/firebase_options.dart';
import 'package:smart_attendance/config/theme.dart' as app_theme;
import 'package:smart_attendance/app/routes.dart' as app_routes;

void main() async {
  //we are loading the .env file here because we are using it in the firebase_options.dart file
  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    debugPrint("No .env File found!!");
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => OnboardingBloc()),
      ],
      child: const MyApp(),
    ),
  );
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
