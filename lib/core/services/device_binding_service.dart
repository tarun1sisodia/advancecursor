import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance/core/error/app_error.dart';
import 'package:smart_attendance/core/services/error_reporting_service.dart';
import 'package:smart_attendance/core/services/encryption_service.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class DeviceBindingService {
  final DeviceInfoPlugin _deviceInfo;
  final SharedPreferences _prefs;
  final ErrorReportingService _errorReporting;
  final EncryptionService _encryption;
  
  static const String _deviceIdKey = 'device_binding_id';
  static const String _deviceBindingKey = 'device_binding_data';
  static const String _bindingTimeKey = 'device_binding_time';

  DeviceBindingService(
    this._prefs,

    this._errorReporting,
    this._encryption,
  ) : _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    try {
      String? deviceId = _prefs.getString(_deviceIdKey);
      
      if (deviceId == null) {
        deviceId = const Uuid().v4();
        await _prefs.setString(_deviceIdKey, await _encryption.encrypt(deviceId));
      }

      return _encryption.decrypt(deviceId);
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.getDeviceId');
      throw DeviceBindingError('Failed to get device ID');
    }
  }

  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      if (await isDeviceDeveloperModeEnabled()) {
        throw DeviceBindingError('Developer mode is enabled');
      }

      final androidInfo = await _deviceInfo.androidInfo;
      
      return {
        'manufacturer': androidInfo.manufacturer,
        'model': androidInfo.model,
        'androidId': androidInfo.id,
        'brand': androidInfo.brand,
        'device': androidInfo.device,
        'hardware': androidInfo.hardware,
        'isPhysicalDevice': androidInfo.isPhysicalDevice,
        'fingerprint': androidInfo.fingerprint,
        'securityPatch': androidInfo.version.securityPatch,
        'sdkInt': androidInfo.version.sdkInt,
        'release': androidInfo.version.release,
      };
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.getDeviceInfo');
      throw DeviceBindingError('Failed to get device info');
    }
  }

  Future<bool> isDeviceDeveloperModeEnabled() async {
    try {
      final androidInfo = await _deviceInfo.androidInfo;
      return !androidInfo.isPhysicalDevice || androidInfo.version.sdkInt >= 30;
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.isDeviceDeveloperModeEnabled');
      return true;
    }
  }

  Future<void> bindDevice(String userId) async {
    try {
      if (await isDeviceDeveloperModeEnabled()) {
        throw DeviceBindingError('Cannot bind device with developer mode enabled');
      }

      final deviceId = await getDeviceId();
      final deviceInfo = await getDeviceInfo();
      final bindingTime = DateTime.now().toIso8601String();

      final bindingData = {
        'userId': userId,
        'deviceId': deviceId,
        'bindingTime': bindingTime,
        'deviceInfo': deviceInfo,
      };

      final encryptedData = await _encryption.encrypt(bindingData.toString());
      await _prefs.setString(_deviceBindingKey, encryptedData);
      await _prefs.setString(_bindingTimeKey, bindingTime);
      
      _errorReporting.setCustomKey('deviceId', deviceId);
      _errorReporting.setCustomKey('bindingTime', bindingTime);
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.bindDevice');
      throw DeviceBindingError('Failed to bind device');
    }
  }

  Future<bool> verifyDeviceBinding(String userId) async {
    try {
      if (await isDeviceDeveloperModeEnabled()) {
        return false;
      }

      final encryptedData = _prefs.getString(_deviceBindingKey);
      if (encryptedData == null) return false;

      final bindingData = await _encryption.decrypt(encryptedData);
      final currentDeviceId = await getDeviceId();
      
      return bindingData.toString().contains(userId) && bindingData.toString().contains(currentDeviceId);
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.verifyDeviceBinding');
      return false;
    }
  }
  Future<void> unbindDevice() async {
    try {
      await _prefs.remove(_deviceBindingKey);
      await _prefs.remove(_bindingTimeKey);
      _errorReporting.setCustomKey('deviceId', null);
      _errorReporting.setCustomKey('bindingTime', null);
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.unbindDevice');
      throw DeviceBindingError('Failed to unbind device');
    }
  }

  Future<Map<String, dynamic>> getBindingStatus() async {
    try {
      final deviceId = await getDeviceId();
      final bindingTime = _prefs.getString(_bindingTimeKey);
      final isDeveloperMode = await isDeviceDeveloperModeEnabled();

      return {
        'isBound': bindingTime != null,
        'deviceId': deviceId,
        'isDeveloperMode': isDeveloperMode,
        'bindingTime': bindingTime,
      };
    } catch (e, stackTrace) {
      _errorReporting.reportError(e, stackTrace, context: 'DeviceBindingService.getBindingStatus');
      throw DeviceBindingError('Failed to get binding status');
    }
  }
}