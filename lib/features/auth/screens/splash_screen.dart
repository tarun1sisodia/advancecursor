import 'package:flutter/material.dart';
import 'package:smart_attendance/app/routes.dart';
import 'package:smart_attendance/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Show splash for 2 seconds

    final prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (hasSeenOnboarding) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100, color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              'Smart Campus',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Attendance Made Smart',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
