import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class SystemChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.system);

  Future<Map<String, dynamic>> getSystemInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        MethodNames.getSystemInfo,
      );
      final data = Map<String, dynamic>.from(result);
      LogHelper.nativeData('System', data);
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get system info: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getCpuInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        MethodNames.getCpuInfo,
      );
      final data = Map<String, dynamic>.from(result);
      LogHelper.nativeData('CPU', data);
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get CPU info: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getMemoryInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        MethodNames.getMemoryInfo,
      );
      final data = Map<String, dynamic>.from(result);
      LogHelper.nativeData('Memory', data);
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get memory info: ${e.message}');
    }
  }
}
