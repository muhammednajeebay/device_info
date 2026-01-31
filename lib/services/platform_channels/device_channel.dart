import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class DeviceChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.device);

  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        MethodNames.getDeviceInfo,
      );
      final data = Map<String, dynamic>.from(result);
      LogHelper.nativeData('Device', data);
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get device info: ${e.message}');
    }
  }
}
