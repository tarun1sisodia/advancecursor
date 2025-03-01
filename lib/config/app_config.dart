import 'package:shared_preferences/shared_preferences.dart';

class Environment {
  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String staging = 'staging';

  static String currentEnvironment = dev;

  static String get apiUrl {
    switch (currentEnvironment) {
      case dev:
        return 'http://localhost:8080/api';
      case staging:
        return 'https://staging-api.smartattendance.com/api';
      case prod:
        return 'https://api.smartattendance.com/api';
      default:
        return 'http://localhost:8080/api';
    }
  }

  static bool get isDev => currentEnvironment == dev;
  static bool get isStaging => currentEnvironment == staging;
  static bool get isProd => currentEnvironment == prod;
}

class AppConfig {
  static const String appName = 'Smart Attendance';
  static const String appVersion = '1.0.0';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String attendanceEndpoint = '/attendance/mark';

  // Timeouts
  static const int connectionTimeout = 5000; // milliseconds
  static const int receiveTimeout = 3000; // milliseconds

  // Cache Configuration
  static const int maxCacheSize = 100;
  static const int maxCacheSizeBytes = 50 << 20; // 50 MB

  // Location Configuration
  static const int locationTimeout = 10000; // milliseconds
  static const double locationAccuracy = 50.0; // meters

  // Session Configuration
  static const Duration sessionTimeout = Duration(minutes: 30);
  static const Duration tokenRefreshThreshold = Duration(minutes: 5);

  static const String _onboardingKey = 'hasSeenOnboarding';

  // Method to mark onboarding as complete
  static Future<void> markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  // Method to check if onboarding has been completed
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ??
        false; // Default to false if not set
  }
}
