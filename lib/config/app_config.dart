import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  static late final Environment environment;
  static late final String apiBaseUrl;
  static late final String appName;

  static void initialize(Environment env) {
    environment = env;

    switch (environment) {
      case Environment.dev:
        apiBaseUrl = 'http://localhost:8080/api';
        appName = 'Smart Campus (Dev)';
        break;
      case Environment.staging:
        apiBaseUrl = 'https://staging-api.smartcampus.com/api';
        appName = 'Smart Campus (Staging)';
        break;
      case Environment.prod:
        apiBaseUrl = 'https://api.smartcampus.com/api';
        appName = 'Smart Campus';
        break;
    }
  }

  static bool get isDevelopment => environment == Environment.dev;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.prod;

  // API Endpoints
  static String get loginEndpoint => '$apiBaseUrl/auth/login';
  static String get registerEndpoint => '$apiBaseUrl/auth/register';
  static String get refreshTokenEndpoint => '$apiBaseUrl/auth/refresh';
  static String get logoutEndpoint => '$apiBaseUrl/auth/logout';
  static String get createSessionEndpoint => '$apiBaseUrl/sessions/create';
  static String get activeSessionsEndpoint => '$apiBaseUrl/sessions/active';
  static String get markAttendanceEndpoint => '$apiBaseUrl/attendance/mark';
  // Add JWT configuration
  static const Duration jwtExpirationDuration = Duration(days: 7);
  static const String jwtSecretKey = 'your_jwt_secret_key';
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  
  // Firebase configuration
  static const String firebaseWebApiKey = 'your_firebase_web_api_key';
  static const String firebaseDynamicLinkDomain = 'your_dynamic_link_domain';

  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableBiometricAuth = true;
  static const bool enableLocationVerification = true;
  static const bool enableWifiVerification = true;

  // Timeouts and Durations
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int defaultSessionDuration = 300; // 5 minutes
  static const int locationUpdateInterval = 60; // 1 minute
  static const int maxRetryAttempts = 3;
  static const int cacheDuration = 7; // 7 days

  // Location Configuration
  static const int defaultLocationRadius = 100; // meters
  static const double defaultLocationAccuracy = 50.0; // meters

  // Debug Configuration
  static bool get enableLogging => !isProduction;
  static bool get enableCrashlytics => isProduction;

  static const String _onboardingKey = 'hasSeenOnboarding';

  // Keep existing utility methods
  static Future<void> markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> clearOnboardingState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }

  static String generateUUID() {
    return Uuid().v4();
  }

  static Future<String> getDeviceUUID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceUUID') ?? generateUUID();
  }

  static Future<void> storeUserUUID(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUUID', uuid);
  }
}