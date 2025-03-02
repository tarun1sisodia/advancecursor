/// Base class for all application-specific errors
class AppError implements Exception {
  final String message;
  final dynamic cause;
  final StackTrace? stackTrace;
  final String? code;

  AppError(
    this.message, {
    this.cause,
    this.stackTrace,
    this.code,
  });

  @override
  String toString() {
    if (cause != null) {
      return '$message (Cause: $cause)';
    }
    return message;
  }

  static unauthenticated() {}

  static unauthorized() {}

  // static AppError network(String s) {}

  // static AppError server(String s) {}

  static attendanceVerificationError(String s) {}

  static wifiService(String s) {}
}

/// Network related errors
class NetworkError extends AppError {
  NetworkError(String message, {dynamic cause}) : super(message, cause: cause);
}

/// Authentication related errors
class AuthError extends AppError {
  AuthError(String message, {String? code}) : super(message, code: code);
}

/// Location service errors
class LocationError extends AppError {
  LocationError(String message) : super(message);
}

/// Database related errors
class DatabaseError extends AppError {
  DatabaseError(String message, {dynamic cause}) : super(message, cause: cause);
}

/// Attendance verification errors
class AttendanceError extends AppError {
  AttendanceError(String message, {String? code}) : super(message, code: code);
}

/// Cache related errors
class CacheError extends AppError {
  CacheError(String message) : super(message);
}

/// Permission related errors
class PermissionError extends AppError {
  PermissionError(String message) : super(message);
}

/// Device binding errors
class DeviceBindingError extends AppError {
  DeviceBindingError(String message) : super(message);
}

/// Configuration errors
class ConfigError extends AppError {
  ConfigError(String message) : super(message);
}

/// Encryption/Decryption errors
class CryptoError extends AppError {
  CryptoError(String message, {dynamic cause}) : super(message, cause: cause);
}

class LocationServiceError extends AppError {
  LocationServiceError(String message) : super(message);

  static LocationServiceError disabled() {
    return LocationServiceError('Location services are disabled');
  }

  static LocationServiceError permissionDenied() {
    return LocationServiceError('Location permission denied');
  }

  static LocationServiceError permanentlyDenied() {
    return LocationServiceError('Location permissions are permanently denied');
  }
}

class LocationPermissionError extends AppError {
  LocationPermissionError(String message) : super(message);
}

class LocationCalculationError extends AppError {
  LocationCalculationError(String message) : super(message);
}

class unauthenticatedError extends AppError {
  unauthenticatedError(String message) : super(message);
}