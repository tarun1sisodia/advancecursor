import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attendance/core/error/app_error.dart';
import 'package:smart_attendance/core/services/logger_service.dart';

@lazySingleton
class ErrorReportingService {
  final LoggerService _logger;
  final FirebaseCrashlytics _crashlytics;

  ErrorReportingService(this._logger) : _crashlytics = FirebaseCrashlytics.instance;

  Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = _crashlytics.recordFlutterError;
  }

  void reportError(dynamic error, StackTrace stackTrace, {String? context}) {
    if (error is AppError) {
      _handleAppError(error, stackTrace, context);
    } else {
      _handleGenericError(error, stackTrace, context);
    }
  }

  void _handleAppError(AppError error, StackTrace stackTrace, String? context) {
    _logger.error(
      'AppError: ${error.message}${context != null ? ' in $context' : ''}',
      error.cause,
      error.stackTrace ?? stackTrace,
    );

    _crashlytics.recordError(
      error,
      error.stackTrace ?? stackTrace,
      reason: context,
      fatal: _isFatalError(error),
    );
  }

  void _handleGenericError(dynamic error, StackTrace stackTrace, String? context) {
    _logger.error(
      'Error occurred${context != null ? ' in $context' : ''}',
      error,
      stackTrace,
    );

    _crashlytics.recordError(error, stackTrace, reason: context);
  }

  void reportWarning(String message, {String? context}) {
    _logger.warning('Warning: $message${context != null ? ' in $context' : ''}');
    _crashlytics.log('Warning: $message${context != null ? ' in $context' : ''}');
  }

  bool _isFatalError(AppError error) {
    return error is AuthError || 
           error is DatabaseError || 
           error is ConfigError;
  }

  Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }
}