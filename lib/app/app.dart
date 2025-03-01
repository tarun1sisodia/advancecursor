import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../config/theme.dart';
import 'routes.dart';

class SmartAttendanceApp extends StatelessWidget {
  const SmartAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          ThemeMode.system, // Automatically use light/dark based on system
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: (settings) {
        // Handle dynamic routes here if needed
        return null;
      },
      builder: (context, child) {
        // Add any app-wide builders here (e.g., for showing dialogs, loading indicators)
        return child!;
      },
    );
  }
}
